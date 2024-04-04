Class {
	#name : #SimpleGraph,
	#superclass : #Object,
	#category : #'Simple-Visaulizer'
}

{ #category : #walking }
SimpleGraph >> findall: parser [
	"Finds all nodes in the graph."

	| all |
	"Parser is currently Unused"
	all := Dictionary new.
	SimpleParser startNode outputs do: [ :node | self walk: node into: all ].
	^ all values
]

{ #category : #walking }
SimpleGraph >> walk: node into: allNodes [
	"Walk a subgraph and populate distinct nodes in the all dictionary"

	"Been there done that"
	(allNodes includesKey: node nid) ifTrue: [ ^ nil ].
	allNodes at: node nid put: node.

	node inputs do: [ :inode | self walk: inode into: allNodes ].
	node outputs do: [ :onode | self walk: onode into: allNodes ]
]
