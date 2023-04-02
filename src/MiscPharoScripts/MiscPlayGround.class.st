"
I represent various ideas of playing around with Pharo.

I know about random examples that are ran, it is best never to use me in real code, but to look at me for examples for playing with aspects.

Some examples include the playground of playing around with:

- Files
- Method resolutions
- Meta Knowledge
"
Class {
	#name : #MiscPlayGround,
	#superclass : #Object,
	#category : #MiscPharoScripts
}

{ #category : #'API - files' }
MiscPlayGround class >> MethodResolver [

	"I represent some examples of resolving methods and classes"

	"scope: class-variables  &  class-instance-variables"

	|  |
	Integer methodNamed: #factorial.


(Integer>>#factorial)  class.

Integer >> #factorial .

^ SequenceableCollection  >> #reversed .
]

{ #category : #'API - files' }
MiscPlayGround class >> StreamExample [

	"I play around with Pharo File Streams. I make the foo file and read from it"

	"scope: class-variables  &  class-instance-variables"

	| stream answer file |
	file := FileLocator home / 'foo.txt'.

	stream := file resolve writeStream.

	stream nextPutAll: 'Hello joe'.
	stream crlf.
	stream close.

	stream := file resolve readStream.

	answer := stream upToEnd.
	stream close.
	^ answer
]
