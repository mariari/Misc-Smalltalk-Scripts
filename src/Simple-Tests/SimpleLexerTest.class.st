Class {
	#name : #SimpleLexerTest,
	#superclass : #TestCase,
	#category : 'Simple-Tests'
}

{ #category : #tests }
SimpleLexerTest >> testEnoughSpace [

	| lex |
	lex := SimpleLexer source: '     hi'.

	lex skipWhitespace.

	self assert: (lex enoughSpace: 2).
	self deny: (lex enoughSpace: 3)
]

{ #category : #tests }
SimpleLexerTest >> testGetAnyNextToken [

	| lex |
	lex := SimpleLexer source: 'The ;Narn 1234Regime'.
	self assert: lex getAnyNextToken equals: 'The'.
	lex skipWhitespace.
	self assert: lex getAnyNextToken equals: ';'.
	self assert: lex getAnyNextToken equals: 'Narn'.
]

{ #category : #tests }
SimpleLexerTest >> testMatch [

	| lex |
	lex := SimpleLexer source: '    The Great  Centari Replubic'.
	self deny: (lex match: 'Great').
	self assert: (lex match: 'The').
	self assert: (lex match: 'Great').
]

{ #category : #tests }
SimpleLexerTest >> testParseNumber [

	| lex |
	lex := SimpleLexer source: '1231'.
	self assert: lex parseNumber val equals: 1231.
	self should: [ lex parseNumber ] raise: Error.
	
	lex := SimpleLexer source: '123451Nimbari'.
	self assert: lex parseNumber val equals: 123451.
	self assert: lex getAnyNextToken equals: 'Nimbari' 
]

{ #category : #tests }
SimpleLexerTest >> testSkipWhiteSpace [

	| lex |
	lex := SimpleLexer source: '     hi'.

	lex skipWhitespace.

	self assert: lex peek equals: $h
]
