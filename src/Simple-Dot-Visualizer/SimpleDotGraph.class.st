Class {
	#name : #SimpleDotGraph,
	#superclass : #SimpleGraph,
	#category : #'Simple-Dot-Visualizer-Base'
}

{ #category : #accessing }
SimpleDotGraph >> generateDotOutput: aParser [
	| stream all |
	stream := WriteStream on: String new.
	all := self findall: aParser.
	stream
		nextPutAll: 'digraph simple {';
		cr;
		nextPutAll: '/*';
		cr;
		nextPutAll: aParser src;
		cr;
		nextPutAll: '*/';
		cr.	"To keep the Scopes below the graph and pointing up into the graph we
need to group the Nodes in a subgraph cluster, and the scopes into a
different subgraph cluster.  THEN we can draw edges between the
scopes and nodes.  If we try to cross subgraph cluster borders while
still making the subgraphs DOT gets confused."
	stream
		tab;
		nextPutAll: 'rankdir=BT;';
		cr;
		tab;
		nextPutAll: 'ordering="in";';
		cr;
		tab;
		nextPutAll: 'concentrate="true";';
		cr.
	self nodes: all with: stream.
	self nodesEdges: all with: stream.

	stream nextPutAll: '}'.
	^ stream contents
]

{ #category : #accessing }
SimpleDotGraph >> nodes: allNodes with: aWriteStream [
	"Let us first write all nodes, no edges"

	aWriteStream
		tab;
		nextPutAll: 'subgraph cluster_Nodes {';
		cr.
	allNodes
		do: [ :n | 
			aWriteStream
				tab;
				tab;
				nextPutAll: n uniqueName;
				nextPutAll: ' [ '.
			n isCFG
				ifTrue: [ aWriteStream nextPutAll: 'shape=box style=filled fillcolor=yellow ' ].
			aWriteStream
				nextPutAll: 'label="';
				nextPutAll: n glabel;
				nextPutAll: '"];';
				cr ].
	aWriteStream
		tab;
		nextPutAll: '}';
		cr
]

{ #category : #accessing }
SimpleDotGraph >> nodesEdges: allNodes with: aWriteStream [
	"Let us first write all nodes, no edges"

	aWriteStream
		tab;
		nextPutAll: 'edge [ fontname=Helvetica, fontsize=8 ];';
		cr.
	allNodes
		do: [ :n | 
			n inputs
				doWithIndex: [ :def :index | 
					def isNotNil
						ifTrue: [ aWriteStream
								tab;
								nextPutAll: n uniqueName;
								nextPutAll: ' -> ';
								nextPutAll: def uniqueName;
								nextPutAll: '[taillabel="';
								nextPut: $1;
								nextPutAll: '" '.

							(n isKindOf: SimpleConstantNode) & (def isKindOf: SimpleStartNode)
								ifTrue: [ aWriteStream nextPutAll: ' style=dotted' ].
							def isCFG ifTrue: [ aWriteStream nextPutAll: ' color=red' ].
							aWriteStream
								nextPutAll: '];';
								cr ] ] ]
]
