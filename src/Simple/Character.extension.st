Extension { #name : #Character }

{ #category : #'*Simple' }
Character >> isSimpleIdLetter [
	"Checks if it is one of the punctuation symbols in the simple language"

	^ self isAlphaNumeric or: [ self = $_ ]
]

{ #category : #'*Simple' }
Character >> isSimpleIdStart [
	"Checks if it is one of the punctuation symbols in the simple language"

	^ self isLetter or: [ self = $_ ]
]

{ #category : #'*Simple' }
Character >> isSimplePunctuation [
	"Checks if it is one of the punctuation symbols in the simple language"

	^ '=;[]<>()+-/*' includes: self
]
