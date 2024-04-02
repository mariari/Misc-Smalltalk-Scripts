"
A SimpleAddNodeTest is a test class for testing the behavior of SimpleAddNode
"
Class {
	#name : #SimpleAddNodeTest,
	#superclass : #TestCase,
	#category : 'Simple-Tests'
}

{ #category : #tests }
SimpleAddNodeTest >> testCompute [

	| node_1 node_2 node_3 node_4 |
	node_1 := SimpleConstantNode newNode: (SimpleIntegerType constant: 3).

	node_2 := SimpleAddNode left: node_1 right: node_1.

	self assert: node_2 compute val equals: 6.

	node_3 := SimpleNode newNode: { }.
	node_4 := SimpleAddNode left: node_3 right: node_1.
	self assert: node_4 compute getType equals: SimpleType bottom getType
]
