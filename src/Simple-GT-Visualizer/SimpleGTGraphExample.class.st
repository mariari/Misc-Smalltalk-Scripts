Class {
	#name : #SimpleGTGraphExample,
	#superclass : #TestCase,
	#category : #'Simple-GT-Visualizer-Examples'
}

{ #category : #visualization }
SimpleGTGraphExample >> basicGraph: nodes [
	^ self
		basicGraph: nodes
		withView: self defaultGraph
]

{ #category : #visualization }
SimpleGTGraphExample >> basicGraph: nodes withView: view [
	self basicGraphNodes: nodes withView: view.
	self basicGraphEdges: nodes withView: view.
	view layout
		tree
		levelDistance: 15;
		nodeDistance: 15.
	^ view
]

{ #category : #visualization }
SimpleGTGraphExample >> basicGraphEdges: nodes withView: view [
	view edges
		stencil: [ :toNode :fromElementVisual :toElement | 
			| color fromNode border simpToStart edgeNumber |
			fromNode := fromElementVisual graph model.

			simpToStart := (toNode isKindOf: SimpleConstantNode)
					& (fromNode isKindOf: SimpleStartNode).

			color := simpToStart
					ifTrue: [ Color blue alpha: 0.5 ]
					ifFalse: [ fromNode isCFG
							ifTrue: [ Color red alpha: 1.0 ]
							ifFalse: [ Color black alpha: 1.0 ] ].

			edgeNumber := (toNode inputs indexOf: fromNode).
			
			border := BlBorder paint: color width: 1.
			border := simpToStart
					ifTrue: [ border copyWithStyle: BlStrokeStyle dashed ]
					ifFalse: [ border ].

			BlBezierElement new
				border: border;
				zIndex: -1;
				fromHead: (BlArrowheadSimpleArrow new background: color);
				toHead: (BlTextElement new text: edgeNumber asString asRopedText)];
		connectFromAll: [ :node | node inputs ]
]

{ #category : #visualization }
SimpleGTGraphExample >> basicGraphNodes: nodes withView: view [
	view nodes
		shape: [ :each | 
			| geo color |
			geo := each isCFG
					ifTrue: [ BlRectangleGeometry new ]
					ifFalse: [ BlEllipseGeometry new ].
			color := each isCFG ifTrue: [ Color yellow ] ifFalse: [ Color white ].
			BlTextElement new
				text: each glabel asRopedText;
				background: color;
				padding: (BlInsets all: 20);
				geometry: geo;
				border: (BlBorder paint: Color black) ];
		with: nodes
]

{ #category : #example }
SimpleGTGraphExample >> defaultGraph [
	<gtExample>
	| view |
	view := GtMondrian new.
	view edges fromCenterBottom.
	^ view
]
