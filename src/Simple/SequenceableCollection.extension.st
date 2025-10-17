Extension { #name : #SequenceableCollection }

{ #category : #'*Simple' }
SequenceableCollection >> startsWith: collection at: index [
	"Checks if I at the index starts with the given collection"

	index - 1 + collection size > self size ifTrue: [ ^ false ].
	collection withIndexDo: 
	[ :s :i | (self at: i - 1 + index) = s ifFalse: [ ^ false ] ].
	^ true
]
