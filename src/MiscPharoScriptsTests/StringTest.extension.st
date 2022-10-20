Extension { #name : #StringTest }

{ #category : #'*MiscPharoScriptsTests' }
StringTest >> testIsPalendrome [

	self assert: 'elle' isPalendrome equals: true.
	self assert: 'hello' isPalendrome equals: false.
	self assert: '台灣第一' isPalendrome equals: false.
]
