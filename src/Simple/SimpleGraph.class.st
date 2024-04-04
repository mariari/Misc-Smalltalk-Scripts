Class {
	#name : #SimpleGraph,
	#superclass : #Object,
	#category : #'Simple-Visaulizer'
}

{ #category : #walking }
SimpleGraph >> findInputsView: node [
	"Finds all nodes in the graph."

	| all |
	"Parser is currently Unused"
	all := Dictionary new.
	self walkInputs: node into: all.
	^ all values
]

{ #category : #walking }
SimpleGraph >> findLocalView: node [
	"Finds all nodes in the graph."

	| all |
	"Parser is currently Unused"
	all := Dictionary new.
	self walk: node into: all.
	^ all values
]

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

	(node inputs select: [ :e | e notNil ])
		do: [ :inode | self walk: inode into: allNodes ].
	(node outputs select: [ :e | e notNil ])
		do: [ :onode | self walk: onode into: allNodes ]
]

{ #category : #walking }
SimpleGraph >> walkInputs: node into: allNodes [
	"Walk a subgraph and populate distinct nodes in the all dictionary"

	"Been there done that"

	(allNodes includesKey: node nid) ifTrue: [ ^ nil ].
	allNodes at: node nid put: node.

	(node inputs select: [ :e | e notNil ])
		do: [ :inode | self walkInputs: inode into: allNodes ].
]
