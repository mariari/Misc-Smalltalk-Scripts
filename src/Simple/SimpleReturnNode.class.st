"
I have two inputs.  The first input is a control node and the second is the data node that supplies the return value.

- In this presentation, I function as a Stop node, since multiple `return` statements are not possible.
- The Stop node will be introduced in Chapter 6 when we implement  `if` statements.

- My output is the value from the data node.
"
Class {
	#name : #SimpleReturnNode,
	#superclass : #SimpleNode,
	#category : #'Simple-Base'
}

{ #category : #'instance creation' }
SimpleReturnNode class >> control: ctrl data: data [
	"See my documentation for more information"
	^ self newNode: {
			  ctrl.
			  data }
]

{ #category : #analysis }
SimpleReturnNode >> compute [
	"This function needs to be monotonic: See the Readme of the class for more information"

	^ SimpleType bottom
]

{ #category : #accessing }
SimpleReturnNode >> ctrl [

^ self at: 1
]

{ #category : #accessing }
SimpleReturnNode >> expr [

	^ self at: 2
]

{ #category : #analysis }
SimpleReturnNode >> idealize [

	^ nil
]

{ #category : #testing }
SimpleReturnNode >> isCFG [
	"Checks if the node is a CFG node"

	^ true
]

{ #category : #printing }
SimpleReturnNode >> printSingle: aStream [
	"Tik tok with `#print0On:`"

	aStream nextPutAll: 'return '.
	self expr printSingleCheckDead: aStream.
	aStream nextPutAll: ';'
]
