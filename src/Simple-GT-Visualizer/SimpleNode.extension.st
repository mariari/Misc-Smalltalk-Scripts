Extension { #name : #SimpleNode }

{ #category : #'*Simple-GT-Visualizer' }
SimpleNode >> visualizeLocalNode: aView [
	<gtView>
	| graph |
	^ aView mondrian
		title: 'Node Inputs';
		painting: [ :view | 
			graph := SimpleGraph new findInputsView: self.

			SimpleGTGraphExample new basicGraph: graph withView: view.
			(view nodeAt: self ifAbsent: [ 3 ]) background: Color paleBlue ]
]

{ #category : #'*Simple-GT-Visualizer' }
SimpleNode >> visualizeNode: aView [
	<gtView>
	| graph |
	^ aView mondrian
		title: 'Graph';
		painting: [ :view | 
			graph := SimpleGraph new findLocalView: self.

			SimpleGTGraphExample new basicGraph: graph withView: view.

			(view nodeAt: self ifAbsent: [ 3 ]) background: Color paleBlue ]
]
