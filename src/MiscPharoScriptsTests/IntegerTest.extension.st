Extension { #name : #IntegerTest }

{ #category : #'*MiscPharoScriptsTests' }
IntegerTest >> testIsPalendrome [

	self assert: 131 isPalendrome equals: true.
	self assert: 1131 isPalendrome equals: false.
]
