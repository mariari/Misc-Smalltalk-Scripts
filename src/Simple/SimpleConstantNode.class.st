"
I represents a constant value.  At present, the only constants that we allow are integer literals; therefore Constants contain an integer
value. As we add other types of constants, we will refactor how we represent Constants.


- Constants have no semantic inputs. However, we set Start as an input to Constants to enable a forward graph walk.  This edge carries no semantic meaning, and it is present _solely_ to allow visitation.

- The Constant's value is the value stored in it.
"
Class {
	#name : 'SimpleConstantNode',
	#superclass : 'SimpleNode',
	#instVars : [
		'value'
	],
	#category : 'Simple-Base',
	#package : 'Simple',
	#tag : 'Base'
}

{ #category : 'instance creation' }
SimpleConstantNode class >> newNode: value [
	"Creates a new node"

	| val |
	val := super newNode: {SimpleParser startNode}.
	val setValue: value.
	^ val
]

{ #category : 'getter' }
SimpleConstantNode >> getValue [

	^ value
]

{ #category : 'printing' }
SimpleConstantNode >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that
	identifies the receiver."
	super printOn: aStream.
	aStream nextPutAll:  ': '.
	value printOn: aStream
]

{ #category : 'setter' }
SimpleConstantNode >> setValue: val [
	"Gets the ith input node"

	value := val.
]
