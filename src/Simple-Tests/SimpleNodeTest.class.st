"
A SimpleNodeTest is a test class for testing the behavior of SimpleNode
"
Class {
	#name : #SimpleNodeTest,
	#superclass : #TestCase,
	#category : #'Simple-Tests'
}

{ #category : #accessing }
SimpleNodeTest >> NumericExpressionExample [
	<gtExample>
	| simple |
	SimpleNodePeephole singleton disable.
	simple := SimpleParser source: 'return 1+2*3+-5;'.

	^ simple parse
]

{ #category : #accessing }
SimpleNodeTest >> additionExample [
	<gtExample>
	| simple |
	SimpleNodePeephole singleton disable.
	simple := SimpleParser source: 'return 1+8;'.

	^ simple parse
]

{ #category : #tests }
SimpleNodeTest >> testAt [

	| node_1 node_2 |
	node_1 := SimpleNode newNode: { }.
	node_2 := SimpleNode newNode: { node_1 }.
	self assert: (node_2 at: 1) equals: node_1 .
]

{ #category : #tests }
SimpleNodeTest >> testCompute [

	| node_1 node_2 |
	node_1 := SimpleConstantNode newNode: (SimpleIntegerType constant: 3).

	node_2 := SimpleAddNode left: node_1 right: node_1.

	self assert: node_2 compute val equals: 6
]

{ #category : #tests }
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

{ #category : #tests }
SimpleNodeTest >> testKill [
	| node |
	node := SimpleConstantNode newNode: (SimpleIntegerType constant: 3).
	self assert: node isUnused.
	node kill.
	self
		assert: node isDead
		description: 'We can kill an unused node and it really is dead at the end'
]

{ #category : #tests }
SimpleNodeTest >> testNoSemicolon [

	self should: [ (SimpleParser source: 'return 100') parse ] raise: Error
]

{ #category : #tests }
SimpleNodeTest >> testSimpleProgram [

	| parser ret start expr |
	parser := SimpleParser source: 'return 1;'.
	ret := parser parse.
	start := SimpleParser startNode.

	self assert: ret ctrl equals: start.

	expr := ret expr.
	self assert: expr class equals: SimpleConstantNode.
	self assert: start equals: (expr at: 1).
	self assert: 1 equals: expr getType val
]

{ #category : #tests }
SimpleNodeTest >> testStartingWith0 [
	<gtExample>
	self
		should: [ (SimpleParser source: 'return 0123;') parse ]
		raise: Error.
	^ 5
]
