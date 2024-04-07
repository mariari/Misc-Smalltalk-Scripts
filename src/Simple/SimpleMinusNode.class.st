"
I represent a Unitary Minus node
"
Class {
	#name : #SimpleMinusNode,
	#superclass : #SimpleNode,
	#category : #'Simple-Base'
}

{ #category : #'instance creation' }
SimpleMinusNode class >> newNode: node [
	"Creates a new node"

	^ super newNode: { nil . node }
]

{ #category : #analysis }
SimpleMinusNode >> compute [
	"This function needs to be monotonic: See the Readme of the class for more information"

	| ty |
	ty := (self at: 2) type.
	(ty isKindOf: SimpleIntegerType) ifTrue: [
		^ ty isConstant
			  ifTrue: [ SimpleIntegerType constant: ty val negated ]
			  ifFalse: [ ty ] ].
	^ SimpleType bottom
]

{ #category : #analysis }
SimpleMinusNode >> idealize [
	"TODO: add of 0"
	^ nil
]

{ #category : #printing }
SimpleMinusNode >> printSingle: aStream [
	"Works in tandem with `#printSingleCheckDead`.

	This one should be what the node looks like as if it were basic syntax"

	aStream nextPutAll: '(-'.
	(self at: 2) printSingleCheckDead: aStream.
	aStream nextPutAll: ')'
]
