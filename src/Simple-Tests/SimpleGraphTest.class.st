Class {
	#name : #SimpleGraphTest,
	#superclass : #TestCase,
	#category : #'Simple-Tests'
}

{ #category : #examples }
SimpleGraphTest >> foo [
	<gtExample>
	| simple simple_parse graph stream |
	simple := SimpleParser source: 'return 1+8;'.

	simple_parse := simple parse.

	graph := SimpleGraph new findall: simple.

	stream := WriteStream on: String new.
	^ stream 
]

{ #category : #tests }
SimpleGraphTest >> testFindAllNodes [
	| simple simple_parse graph |
	simple := SimpleParser source: 'return 1+8;'.
	SimpleNodePeephole singleton enable.
	simple_parse := simple parse.

	graph := SimpleGraph new findall: simple.
	self
		assert: (graph contains: [ :n | n label = 'Start' ]);
		assert: (graph contains: [ :n | n label = 'Return' ]);
		assert: (graph contains: [ :n | n label = 'Constant' ])
]
