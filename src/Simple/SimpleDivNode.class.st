"
I represent a Division node
"
Class {
	#name : #SimpleDivNode,
	#superclass : #SimpleNode,
	#category : 'Simple-Base'
}

{ #category : #'as yet unclassified' }
SimpleDivNode class >> left: lhs  right: rhs [
	"Creates a new node"

	^ self newNode: { nil. lhs. rhs }
]

{ #category : #analysis }
SimpleDivNode >> compute [
	"This function needs to be monotonic: See the Readme of the class for more information"

	^ self computeBiOpNumberWith: [ :ty1 :ty2 |
		  ty1 val isZero
			  ifTrue: [ SimpleIntegerType zero ]
			  ifFalse: [ SimpleIntegerType constant: ty1 val / ty2 val ] ]
]

{ #category : #analysis }
SimpleDivNode >> idealize [
	"TODO: add of 0"
	^ nil
]

{ #category : #printing }
SimpleDivNode >> printSingle: aStream [
	"Works in tandem with `#printSingleCheckDead`.

	This one should be what the node looks like as if it were basic syntax"

	aStream nextPutAll: '('.
	(self at: 2) printSingleCheckDead: aStream.
	aStream nextPutAll: '/'.
	(self at: 3) printSingleCheckDead: aStream.
	aStream nextPutAll: ')'
]
