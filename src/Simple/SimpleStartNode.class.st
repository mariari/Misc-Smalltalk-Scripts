"
I Start node represents the start of the function.  

For now, we do not have any inputs to myself because our function does not yet accept parameters.  

When we add parameters the value of Start will be a tuple, and will require Projections to extract the values.
We discuss this in detail in Chapter 9: Functions and Calls.
"
Class {
	#name : #SimpleStartNode,
	#superclass : #SimpleNode,
	#category : 'Simple-Base'
}

{ #category : #testing }
SimpleStartNode >> isCFG [
	"Checks if the node is a CFG node"

	^ true
]

{ #category : #printing }
SimpleStartNode >> printSingle: aStream [
	"Works in tandem with `#printSingleCheckDead`.

	This one should be what the node looks like as if it were basic syntax"

	aStream nextPutAll: self label
]
