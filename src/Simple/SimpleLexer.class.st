"
I am a lexer for the simple language. SimpleParser uses me internally
"
Class {
	#name : #SimpleLexer,
	#superclass : #Object,
	#instVars : [
		'input',
		'position'
	],
	#category : #'Simple-Parsing'
}

{ #category : #initialization }
SimpleLexer class >> buffer: aCollection [
	"Direct from disk file source"
	^ self new buffer: aCollection
]

{ #category : #initialization }
SimpleLexer class >> source: str [
	"Record the source text for lexing"

	^ self buffer: str asArray 
]

{ #category : #initialization }
SimpleLexer >> buffer: aCollection [

	position := 1.
	input := aCollection.
	^ self
]

{ #category : #'private - utility' }
SimpleLexer >> enoughSpace: length [
	"I check if the given length would go out of the buffer space"

	^ position - 1 + length <= input size
]

{ #category : #'accessing - token' }
SimpleLexer >> getAnyNextToken [
	"I am Used for errors"

	| peeked |
	self isEOF ifTrue: [ ^ '' ].
	peeked := self peek.
	peeked isSimpleIdStart ifTrue: [ ^ self parseId ].
	peeked isSimplePunctuation ifTrue: [ ^ self parsePunctuation ].
	^ peeked asString
]

{ #category : #accessing }
SimpleLexer >> input [
	^ String newFrom: input 
]

{ #category : #'private - testing' }
SimpleLexer >> isEOF [
	"I return true when we are at the EOF"

	^ (self enoughSpace: 1) not
]

{ #category : #testing }
SimpleLexer >> isNumber [

^ self peek isDigit 
]

{ #category : #'private - testing' }
SimpleLexer >> isWhitespace [
	"True if a white space character"

	^ self peek isSeparator 
]

{ #category : #accessing }
SimpleLexer >> match: syntax [
	"I return true if we find 'syntax' after skipping white space; also
	then advance the cursor past syntax. 
	Return false otherwise and I do not advance the cursor"

	| isAtPosition |
	self skipWhitespace.
	isAtPosition := input startsWith: syntax at: position.
	isAtPosition ifTrue: [ position := position + syntax size ].
	^ isAtPosition 
]

{ #category : #'private - tokenizing' }
SimpleLexer >> nextChar [

	| ch | 
	ch := self peek. 
	position := position + 1.
	^ ch
	
]

{ #category : #'private - tokenizing' }
SimpleLexer >> parseId [

	^ self readUntil: [ :char | char isSimpleIdLetter ]
]

{ #category : #'private - tokenizing' }
SimpleLexer >> parseNumber [

	| snum ssize |
	snum := self readUntil: [ :ch | ch isDigit ].
	ssize := snum size.
	ssize = 0 | (ssize > 1 and: [ (snum at: 1) = $0 ]) ifTrue: [
		Error signal: 'Syntax error: integer values cannot start with: 0' ].
	^ SimpleIntegerType withValue: snum  asNumber
]

{ #category : #'private - tokenizing' }
SimpleLexer >> parsePunctuation [
	^ self nextChar asString
]

{ #category : #'private - tokenizing' }
SimpleLexer >> peek [
	"Peek next character, or report EOF"

	^ self isEOF
		  ifTrue:  [ "special value that ends parsing" Character end ]
		  ifFalse: [ (input at: position) asCharacter ]
]

{ #category : #printing }
SimpleLexer >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that
	identifies the receiver."

	super printOn: aStream.
	aStream nextPutAll: '('.
	aStream nextPutAll: (input copyFrom: position  to: input size).
	aStream nextPutAll: ')'.
]

{ #category : #'private - tokenizing' }
SimpleLexer >> readUntil: ablock [
	"reads until the block returns false, moving the parser."

	| start str |
	start := position.
	[  ablock value: self nextChar  ] whileTrue.
	str := input copyFrom: start to: position - 2.
	position := position - 1.
	^ str as: String
]

{ #category : #'private - tokenizing' }
SimpleLexer >> skipWhitespace [
	"Return the next non-white-space character"

	
	[  self isWhitespace ] whileTrue: [  position := position + 1 ]
]
