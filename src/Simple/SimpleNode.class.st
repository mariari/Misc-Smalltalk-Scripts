"
I am a Node in a Sea of Nodes IR. Everyone inherits from me. 


I provide common functionality used by all subtypes. They subtype me by overiding methods. 


# I use an analytic framework for optimization

Namely we use a [monotonic functions](https://en.wikipedia.org/wiki/Monotonic_function).

All of this is apart of a [monotonic analysis framework](https://www.cse.psu.edu/~gxt29/teaching/cse597s21/slides/08monotoneFramework.pdf). The following functions should respect this framework

- `SimpleNode>>#compute`
- `SimpleNode>>#peephole`

For ease of use, we have categorized all of these functions under `SimpleNode>>analysis`

Note that `SimpleNodePeephole class` can turn on and off the peephole optimizer, and ise useful to toggle for visualization and debugging.

"
Class {
	#name : #SimpleNode,
	#superclass : #Object,
	#instVars : [
		'nid',
		'inputs',
		'outputs',
		'type'
	],
	#category : #'Simple-Base'
}

{ #category : #'instance creation' }
SimpleNode class >> newNode: nodes [
	"Creates a new node"


	^ self new inputs: nodes with: SimpleNodeCounter singleton newNode 
]

{ #category : #'private - adding' }
SimpleNode >> addOutput: node [
	"I add an output node to myself. 
	I assume the node adding me already added me as input

	I may break the edge invariants if not used carefully"

	outputs addLast: node
]

{ #category : #accessing }
SimpleNode >> at: index [
	"Gets the ith input node, may return a `SimpleNode` or nil"

	^ inputs at: index
]

{ #category : #analysis }
SimpleNode >> compute [
	"This function needs to be monotonic: See the Readme of the class for more information"

	self subclassResponsibility
]

{ #category : #'private - analysis' }
SimpleNode >> computeBiOpNumberWith: ablock [

	| ty1 ty2 |
	ty1 := (self at: 2) type.
	ty2 := (self at: 3) type.
	(ty2 isKindOf: SimpleIntegerType) & (ty1 isKindOf: SimpleIntegerType)
		ifTrue: [
			ty1 isConstant & ty2 isConstant ifTrue: [
				^ ablock value: ty1 value: ty2 ] ].

	^ SimpleType bottom
]

{ #category : #printing }
SimpleNode >> deadName [
	"The name that gets printed when the Node is dead. Typically unique: dead"

	^ self uniqueName , '(Dead)'
]

{ #category : #'private - removing' }
SimpleNode >> delUse: node [
	"We remove the used node from our use list
	This is likely triggered as that node has stop using us :("

	outputs removeAtShuffle: (outputs indexOf: node).
	^ outputs size isZero
]

{ #category : #getter }
SimpleNode >> getType [

	^ type
]

{ #category : #printing }
SimpleNode >> glabel [
	"The graphical label of the given node.
	This is different from the label in that some
	nodes may wish to have a different label when grpahically dispalyed"

	^ self label
]

{ #category : #analysis }
SimpleNode >> idealize [

	self subclassResponsibility
]

{ #category : #sizes }
SimpleNode >> inputSize [
"Gets the size of the inputs"

^ inputs size
]

{ #category : #sizes }
SimpleNode >> inputs [
	"Inputs to the node. These are use-def references to Nodes.
     Generally fixed length, ordered, nulls allowed, no unused trailing space.
     Ordering is required because e.g. ""a/b"" is different from ""b/a"".
     The first input (offset 1) is often a {@link #isCFG} node."

	^ inputs
]

{ #category : #creation }
SimpleNode >> inputs: nodes with: id [

	nid := id.
	inputs := OrderedCollection withAll: nodes.
	outputs := OrderedCollection empty.
	nodes do: [ :n | n ifNotNil: [ n addOutput: self ] ]
]

{ #category : #testing }
SimpleNode >> isCFG [
	"Checks if the node is a CFG node"

	^ false
]

{ #category : #testing }
SimpleNode >> isDead [
	"I'm mostly used for assertions and testing"

	^ self isUnused & (self inputSize = 0) & type isNil
]

{ #category : #testing }
SimpleNode >> isUnused [
	"Checks if the node is unused"

	^ outputs isEmpty 
]

{ #category : #'private - removing' }
SimpleNode >> kill [
	"Kills the node"

	[ self isUnused ] assert.

	1 to: inputs size do: [ :i | self unsetAt: i ].
	"slow find better"
	inputs removeAll.
	self setType: nil.
	[ self isDead ] assert
]

{ #category : #printing }
SimpleNode >> label [
	"The label of the given node. Useful for debugging and inspecting."

	^ ((self class name withoutSuffix: 'Node') withoutPrefix:
		          'Simple') ifEmpty: [ 'Node' ]
]

{ #category : #accessing }
SimpleNode >> nid [
	"Each node has a unique dense Node ID within a compilation context
	The ID is useful for debugging, for using as an offset in a bitvector,
	as well as for computing equality of nodes (to be implemented later)."

	^ nid
]

{ #category : #sizes }
SimpleNode >> outputSize [
	"Gets the size of the outputs"

	^ outputs size
]

{ #category : #sizes }
SimpleNode >> outputs [
	"Outputs reference Nodes that are not null and have this Node as an input.
	 These nodes are users of this node, thus these are def-use references to Nodes.
	
     Outputs directly match inputs, making a directed graph that can be
     walked in either direction.  These outputs are typically used for
     efficient optimizations but otherwise have no semantics meaning."

	^ outputs
]

{ #category : #analysis }
SimpleNode >> peephole [
	"Try to peephole the node, and find a better replacement for the Node"

	| computed_type n |
	"Compute the initial or improved type"
	computed_type := type := self compute.

	"Don't do anything if the peephole is diabled"
	SimpleNodePeephole singleton isDisabled ifTrue: [ ^ self ].

	type isConstant & (self isKindOf: SimpleConstantNode) not ifTrue: [
		"Replacing this node with the constant, So we kill it"
		"Q: how does this imply `self` is unused to do this?"
		"A: Seems it's not general, chapter 5 fixes this"
		self kill.
		^ (SimpleConstantNode newNode: computed_type) peephole ].
	n := self idealize.
	^ n ifNotNil: [ ^ n ]  ifNil: [ ^ self  ]
]

{ #category : #printing }
SimpleNode >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that
	identifies the receiver."

	self isDead ifFalse: [
		aStream
			nextPutAll: self uniqueName;
			nextPutAll: '('.
			self printSingleCheckDead: aStream.
			aStream nextPutAll: ')']
	ifTrue: [  self printSingleCheckDead: aStream. ]
]

{ #category : #printing }
SimpleNode >> printSingle: aStream [
	"Works in tandem with `#printSingleCheckDead`.

	This one should be what the node looks like as if it were basic syntax"

	^ self subclassResponsibility
]

{ #category : #printing }
SimpleNode >> printSingleCheckDead: aStream [
	"Appends the node to the given Stream.
	This works in tandem with `#printSingle:`

	Namely this does a check if the node is dead,
	and if so dumps the given `#deadName` instead of printing the node.

	Subclasses can leave me alone but ought to change printSingle:"

	self isDead
		ifTrue: [ aStream nextPutAll: self deadName ]
		ifFalse: [ self printSingle: aStream ]
]

{ #category : #setting }
SimpleNode >> setAt: index def: new [
	"Changes the given input(def) node at a location into the given `new` node

	In the process of doing this, this may make the `old` node go dead.
	If the node dies, then we kill the node

	Note that we are corecursive with `kill`"

	"Old represents the old node"

	| old |
	old := self at: index.
	old = new ifTrue: [ ^ self ].
	"we need to add new first else it may recursively get deleted"
	new ifNotNil: [ new addOutput: self ].
	old ifNotNil: [ (old delUse: self) ifTrue: [ old kill ] ].
	inputs at: index put: new.
	^ new
]

{ #category : #setter }
SimpleNode >> setType: val [
	"Gets the ith input node"

	type := val
]

{ #category : #accessing }
SimpleNode >> type [
	"Current computed type for this Node.  
	This value changes as the graph changes 
	and more knowledge is gained about the program."
	^ type
]

{ #category : #printing }
SimpleNode >> uniqueName [
	"Unique label for graph visualization, e.g. ""Add12"" or ""Region30"" or ""EQ99"""

	^ self label , nid asString
]

{ #category : #setting }
SimpleNode >> unsetAt: index [
	"Sets the def (input) node at the given index to nil.

	Erasing the number of defs we use."

	^ self setAt: index def: nil
]
