Extension { #name : 'String' }

{ #category : '*MiscPharoScripts' }
String >> isPalendrome [
	^ self = self reverse .
]
