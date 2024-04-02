Extension { #name : #OrderedCollection }

{ #category : #'*Simple' }
OrderedCollection >> removeAtShuffle: index [
	"Fast Constant Time, element removal. DOES NOT PRESERVE ORDER"

	(index between: 1 and: self size) ifTrue: 
	[ self
		swap: index with: self size;
		removeLast ]
]
