Class {
	#name : #SimpleDotGraphExample,
	#superclass : #TestCase,
	#category : #'Simple-Dot-Visualizer-Base'
}

{ #category : #accessing }
SimpleDotGraphExample >> basicGraph [
	<gtExample>
	| simple simple_parse stream |
	SimpleNodePeephole singleton disable.
	simple := SimpleParser source: 'return 1+8;'.

	simple_parse := simple parse.

	stream := WriteStream on: String new.
	^ SimpleDotGraph new generateDotOutput: simple
]

{ #category : #accessing }
SimpleDotGraphExample >> basicNodeEdges [
	<gtExample>
	| simple simple_parse graph stream |
	simple := SimpleParser source: 'return 1+8;'.

	simple_parse := simple parse.

	graph := SimpleDotGraph new findall: simple.

	stream := WriteStream on: String new.
	SimpleDotGraph new nodesEdges: graph with: stream.
	^ stream contents
]

{ #category : #accessing }
SimpleDotGraphExample >> basicNodes [
	<gtExample>
	| simple simple_parse graph stream |
	simple := SimpleParser source: 'return 1+8;'.

	simple_parse := simple parse.

	graph := SimpleDotGraph new findall: simple.

	stream := WriteStream on: String new.
	SimpleDotGraph new nodes: graph with: stream.
	^ stream contents
]

{ #category : #accessing }
SimpleDotGraphExample >> complexGraph [
	<gtExample>
	| simple simple_parse stream |
	SimpleNodePeephole singleton disable.
	simple := SimpleParser source: 'return 1+2*3+-5;'.

	simple_parse := simple parse.

	stream := WriteStream on: String new.
	^ SimpleDotGraph new generateDotOutput: simple
]
