"
A SimpleNodeTest is a test class for testing the behavior of SimpleNode
"
Class {
	#name : 'SimpleNodeTest',
	#superclass : 'TestCase',
	#category : 'Simple-Tests',
	#package : 'Simple-Tests'
}

{ #category : 'tests' }
SimpleNodeTest >> testAt [

	| node_1 node_2 |
	node_1 := SimpleNode newNode: { }.
	node_2 := SimpleNode newNode: { node_1 }.
	self assert: (node_2 at: 1) equals: node_1 .
]

{ #category : 'tests' }
SimpleNodeTest >> testInputsWith [

	| node_1 node_2 |
	node_1 := SimpleNode newNode: #(  ).
	self assert: node_1 inputSize equals: 0.
	self assert: node_1 outputSize equals: 0.

	node_2 := SimpleNode newNode: { node_1 }.
	self assert: node_2 inputSize equals: 1.
	self assert: node_1 outputSize equals: 1.
	self assert: node_2 isUnused.
]
