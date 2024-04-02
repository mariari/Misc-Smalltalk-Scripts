"
I represent the Integer type
"
Class {
	#name : #SimpleIntegerType,
	#superclass : #SimpleType,
	#instVars : [
		'con'
	],
	#category : 'Simple-Base'
}

{ #category : #'instance creation' }
SimpleIntegerType class >> constant: value [

^ self withValue: value
]

{ #category : #'private - creation' }
SimpleIntegerType class >> withValue: value [

	| val |
	val := super withValue: self int.
	val setValue: value.
	
^val 
]

{ #category : #'instance creation' }
SimpleIntegerType class >> zero [

	^ self withValue: 0
]

{ #category : #comparing }
SimpleIntegerType >> = anObject [
	"Answer whether the receiver and the argument represent the same
	object. If = is redefined in any subclass, consider also redefining the
	message hash."

	self == anObject ifTrue: [  ^ true ].
	^ self class =  anObject class and: [ self val = anObject val ]
]

{ #category : #comparing }
SimpleIntegerType >> hash [
	"Answer a SmallInteger whose value is related to the receiver's identity.
	May be overridden, and should be overridden in any classes that define = "

	^ self val identityHash
]

{ #category : #testing }
SimpleIntegerType >> isConstant [

	^ true
]

{ #category : #printing }
SimpleIntegerType >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that
	identifies the receiver."

	self val printOn: aStream
]

{ #category : #'private - creation' }
SimpleIntegerType >> setValue: val [

con := val 
]

{ #category : #accessing }
SimpleIntegerType >> val [
"The constant value observed for this type"
	^ con
]
