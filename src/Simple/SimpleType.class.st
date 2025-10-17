"
Hello I present Types for the Simple language.

My tese types are part of a [Monotone Analysis Framework](https://www.cse.psu.edu/~gxt29/teaching/cse597s21/slides/08monotoneFramework.pdf) (See the given link for slides)

The types form a [lattice](https://en.wikipedia.org/wiki/Lattice_(order))

This wild lattice theory will be needed later to allow us to easily beef up
the analysis and optimization of the Simple compiler... but we don't need it
now, just know that it is coming along in a later Chapter.

One of the fun things here is that while the theory is deep and subtle, the
actual implementation is darn near trivial and is generally really obvious
what we're doing with it.  Right now, it's just simple integer math to do
simple constant folding e.g. 1+2 == 3 stuff.

"
Class {
	#name : #SimpleType,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#category : 'Simple-Base'
}

{ #category : #types }
SimpleType class >> bot [
"The Bottom (ALL) type"

^ 0
]

{ #category : #'instance creation' }
SimpleType class >> bottom [

	^ self withValue: self bot
]

{ #category : #types }
SimpleType class >> int [
	"the set of integers (`TypeInteger` for more info)"

	^ 3
]

{ #category : #types }
SimpleType class >> simple [
	"End of the simple type"

	^ 2
]

{ #category : #private }
SimpleType class >> strings [

	^ #( Bot Top Simp Int)
]

{ #category : #types }
SimpleType class >> top [
	"The Top (ALL) type"

	^ 1
]

{ #category : #'private - creation' }
SimpleType class >> withValue: value [

	^ self new setTypeValue: value
]

{ #category : #'private - creation' }
SimpleType >> getType [

	^ type
]

{ #category : #testing }
SimpleType >> isConstant [ 

^ type = self class top
]

{ #category : #testing }
SimpleType >> isSimple [

^ type < self class simple
]

{ #category : #rendering }
SimpleType >> present [

	type ifNil: [ ^ 'Unknown' ].
	^ self class strings at: type + 1 ifAbsent: 'Unkown'
]

{ #category : #printing }
SimpleType >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that
	identifies the receiver."

	| title |
	title := self present.
	aStream
		nextPutAll: 'Type: ';
		nextPutAll: title
]

{ #category : #'private - creation' }
SimpleType >> setTypeValue: value [

type := value
]
