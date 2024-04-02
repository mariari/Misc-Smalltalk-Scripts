"
I represents a constant value.  At present, the only constants that we allow are integer literals; therefore Constants contain an integer
value. As we add other types of constants, we will refactor how we represent Constants.


- Constants have no semantic inputs. However, we set Start as an input to Constants to enable a forward graph walk.  This edge carries no semantic meaning, and it is present _solely_ to allow visitation.

- The Constant's value is the value stored in it.
"
Class {
	#name : #SimpleConstantNode,
	#superclass : #SimpleNode,
	#category : 'Simple-Base'
}

{ #category : #'instance creation' }
SimpleConstantNode class >> newNode: value [
	"Creates a new node"

	| val |
	val := super newNode: { SimpleParser startNode }.
	val setType: value.
	^ val
]

{ #category : #analysis }
SimpleConstantNode >> compute [
	"This function needs to be monotonic: See the Readme of the class for more information"

	^ type
]

{ #category : #analysis }
SimpleConstantNode >> idealize [

	^ nil
]

{ #category : #printing }
SimpleConstantNode >> printSingle: aStream [
	"Works in tandem with `#printSingleCheckDead`.
	
	This one should be what the node looks like as if it were basic syntax"

	^ type printOn: aStream
]
