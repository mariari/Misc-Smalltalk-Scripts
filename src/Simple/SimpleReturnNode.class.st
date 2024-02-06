"
I have two inputs.  The first input is a control node and the second is the data node that supplies the return value.

- In this presentation, I function as a Stop node, since multiple `return` statements are not possible.
- The Stop node will be introduced in Chapter 6 when we implement  `if` statements.

- My output is the value from the data node.
"
Class {
	#name : 'SimpleReturnNode',
	#superclass : 'SimpleNode',
	#category : 'Simple-Base',
	#package : 'Simple',
	#tag : 'Base'
}

{ #category : 'instance creation' }
SimpleReturnNode class >> control: ctrl data: data [

	^ self newNode: {
			  ctrl.
			  data }
]

{ #category : 'accessing' }
SimpleReturnNode >> ctrl [

^ self at: 1
]

{ #category : 'accessing' }
SimpleReturnNode >> expr [

	^ self at: 2
]

{ #category : 'testing' }
SimpleReturnNode >> isCFG [
	"Checks if the node is a CFG node"

	^ true
]
