"
I represent a sub node
"
Class {
	#name : #SimpleSubNode,
	#superclass : #SimpleNode,
	#category : 'Simple-Base'
}

{ #category : #'as yet unclassified' }
SimpleSubNode class >> left: lhs  right: rhs [
	"Creates a new node"

	^ self newNode: { nil. lhs. rhs }
]

{ #category : #analysis }
SimpleSubNode >> compute [
	"This function needs to be monotonic: See the Readme of the class for more information"

	^ self computeBiOpNumberWith: [ :ty1 :ty2 |
		  SimpleIntegerType constant: ty1 val - ty2 val ]
]

{ #category : #analysis }
SimpleSubNode >> idealize [
	"TODO: add of 0"
	^ nil
]

{ #category : #printing }
SimpleSubNode >> printSingle: aStream [
	"Works in tandem with `#printSingleCheckDead`.

	This one should be what the node looks like as if it were basic syntax"

	aStream nextPutAll: '('.
	(self at: 2) printSingleCheckDead: aStream.
	aStream nextPutAll: '-'.
	(self at: 3) printSingleCheckDead: aStream.
	aStream nextPutAll: ')'
]
