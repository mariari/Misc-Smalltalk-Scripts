"
I represent a simple parser that converts some source text into a Sea of nodes IR directly in one pass. There is no AST
"
Class {
	#name : 'SimpleParser',
	#superclass : 'Object',
	#instVars : [
		'lexer'
	],
	#classInstVars : [
		'startNode'
	],
	#category : 'Simple-Base',
	#package : 'Simple',
	#tag : 'Base'
}

{ #category : 'creation' }
SimpleParser class >> source: str [
	"comment stating purpose of class-side method"

	"scope: class-variables  &  class-instance-variables"

	SimpleNode initialize.
	startNode  :=  (SimpleStartNode newNode: {  }).
	^ self new
		  lexer: (SimpleLexer source: str)
]

{ #category : 'accessing' }
SimpleParser class >> startNode [
	" A Global Static, unique to each compilation.  This is a public, so we can make constants everywhere without having to thread the StartNode can make constants everywhere without having to thread the StartNode through the entire parser and optimizer.
        - To make the compiler multithreaded, this field will have to move into a TLS"

	^ startNode
]

{ #category : 'error handling' }
SimpleParser >> error: message [

	RuntimeSyntaxError signal: message
]

{ #category : 'private - errors' }
SimpleParser >> errorSyntax: syntax [

	self error: 'syntax error, expected ' , syntax printString , ': '
		  , lexer getAnyNextToken printString
]

{ #category : 'initialization' }
SimpleParser >> lexer: lex [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	lexer := lex.
	^ self
]

{ #category : 'parsing' }
SimpleParser >> parse [


	self require: 'return' returning: ''.
	^ self parseReturn
]

{ #category : 'private - parsing' }
SimpleParser >> parseExpression [
	"Parse an epxression of the form:
	- epxr: Primary Expression"

	^ self parsePrimary
]

{ #category : 'private - parsing' }
SimpleParser >> parseIntegerLiteral [
	"Parse integer literal
	
	- integerLiteral : [1-9][0-9]* | [0]"

	^ SimpleConstantNode newNode: (lexer parseNumber )
]

{ #category : 'private - parsing' }
SimpleParser >> parsePrimary [
	"Parrse a primary expression
	
	- PrimaryExpr : IntegerLiteral"

	lexer skipWhitespace.
	lexer isNumber ifTrue: [ ^ self parseIntegerLiteral ].
	self error: 'Syntax error, expected integer literal'
]

{ #category : 'private - parsing' }
SimpleParser >> parseReturn [
	"I parse a return statemnet. 'return' is already parsed
	
	- 'returns' an expression"

	| expr node |
	node := self parseExpression.
	expr := self require: ';' returning: node.
	^ SimpleReturnNode control: self class startNode data: expr
]

{ #category : 'private' }
SimpleParser >> require: syntax returning: node [
	"Require the given syntax, returning the node if the syntax matches"

	(lexer match: syntax)
		ifTrue: [ ^ node ]
		ifFalse: [ self errorSyntax: syntax ]
]
