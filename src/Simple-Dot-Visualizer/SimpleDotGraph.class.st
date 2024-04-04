Class {
	#name : #SimpleDotGraph,
	#superclass : #SimpleGraph,
	#category : #'Simple-Dot-Visualizer-Base'
}

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
				doWithIndex: [ :def | 
					def isNotNil
						ifTrue: [ aWriteStream
								tab;
								nextPutAll: n uniqueName;
								nextPutAll: ' -> ';
								nextPutAll: def uniqueName;
								nextPutAll: '[taillabel=';
								nextPut: $1.

							(n isKindOf: SimpleConstantNode) & (def isKindOf: SimpleStartNode)
								ifTrue: [ aWriteStream nextPutAll: ' style=dotted' ].
							def isCFG ifTrue: [ aWriteStream nextPutAll: ' color=red' ].
							aWriteStream
								nextPutAll: '"];';
								cr ] ] ]
]
