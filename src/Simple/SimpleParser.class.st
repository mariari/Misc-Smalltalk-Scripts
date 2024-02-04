"
I represent a simple parser that converts some source text into a Sea of nodes IR directly in one pass. There is no AST
"
Class {
	#name : 'SimpleParser',
	#superclass : 'Object',
	#instVars : [
		'startNode',
		'lexer'
	],
	#category : 'Simple-Base',
	#package : 'Simple',
	#tag : 'Base'
}

{ #category : 'creation' }
SimpleParser class >> source: str [
	"comment stating purpose of class-side method"

	"scope: class-variables  &  class-instance-variables"

	^ self new lexer: (SimpleLexer source: str)  startNode: 10
]

{ #category : 'initialization' }
SimpleParser >> lexer: lex startNode: start [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| |
	lexer := lex.
	startNode := start.
	
	^ self
	
]
