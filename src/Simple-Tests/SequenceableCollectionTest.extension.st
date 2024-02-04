Extension { #name : 'SequenceableCollectionTest' }

{ #category : '*Simple-Tests' }
SequenceableCollectionTest >> testStartsWithAt [

	self assert: ('0123456789' startsWith: '12345' at: 2).
	self deny: ('0123456789' startsWith: '12345' at: 3).
	self deny: ('0123456789' startsWith: '1234567890' at: 2)
]
