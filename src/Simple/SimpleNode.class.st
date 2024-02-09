"
I am a Node in a Sea of Nodes IR. Everyone inherits from me. 


I provide common functionality used by all subtypes. They subtype me by overiding methods. 
"
Class {
	#name : 'SimpleNode',
	#superclass : 'Object',
	#instVars : [
		'nid',
		'inputs',
		'outputs',
		'type'
	],
	#category : 'Simple-Base',
	#package : 'Simple',
	#tag : 'Base'
}

{ #category : 'instance creation' }
SimpleNode class >> newNode: nodes [
	"Creates a new node"


	^ self new inputs: nodes with: SimpleNodeCounter singleton newNode 
]

{ #category : 'adding' }
SimpleNode >> addOutput: node [
	"I add an output node to myself. 
	I assume the node adding me already added me as input"

	outputs addLast: node
]

{ #category : 'accessing' }
SimpleNode >> at: index [
	"Gets the ith input node"

	^ inputs at: index
]

{ #category : 'sizes' }
SimpleNode >> inputSize [
"Gets the size of the inputs"

^ inputs size
]

{ #category : 'sizes' }
SimpleNode >> inputs [
	"Inputs to the node. These are use-def references to Nodes.
     Generally fixed length, ordered, nulls allowed, no unused trailing space.
     Ordering is required because e.g. ""a/b"" is different from ""b/a"".
     The first input (offset 1) is often a {@link #isCFG} node."

	^ inputs
]

{ #category : 'creation' }
SimpleNode >> inputs: nodes with: id [

	nid := id.
	inputs := OrderedCollection withAll: nodes.
	outputs := OrderedCollection empty.
	nodes do: [ :n | n addOutput: self ]
]

{ #category : 'testing' }
SimpleNode >> isCFG [
	"Checks if the node is a CFG node"

	^ false
]

{ #category : 'testing' }
SimpleNode >> isUnused [
	"Checks if the node is unused"

	^ outputs isEmpty 
]

{ #category : 'sizes' }
SimpleNode >> outputSize [
	"Gets the size of the outputs"

	^ outputs size
]

{ #category : 'sizes' }
SimpleNode >> outputs [
	"Outputs reference Nodes that are not null and have this Node as an input.
	 These nodes are users of this node, thus these are def-use references to Nodes.
	
     Outputs directly match inputs, making a directed graph that can be
     walked in either direction.  These outputs are typically used for
     efficient optimizations but otherwise have no semantics meaning."

	^ outputs
]

{ #category : 'printing' }
SimpleNode >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that
	identifies the receiver."

	| title |
	title := ((self class name withoutSuffix: 'Node') withoutPrefix:
		          'Simple') ifEmpty: [ 'Node' ].
	aStream nextPutAll: title;
	nextPutAll: ' '.
	nid printOn: aStream
]

{ #category : 'setter' }
SimpleNode >> setType: val [
	"Gets the ith input node"

	type := val
]

{ #category : 'accessing' }
SimpleNode >> type [
	"Current computed type for this Node.  
	This value changes as the graph changes 
	and more knowledge is gained about the program."
	^ type
]
