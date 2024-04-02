"
I help numbering unique nodes in Parsing for SoN
"
Class {
	#name : #SimpleNodeCounter,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Simple-Base'
}

{ #category : #'class initialization' }
SimpleNodeCounter class >> initialize [
	"Upon loading a class, this selector is not looked up.
	If you want a class to be initialized upon loading, this class should define the selector #intialize explicitly"

	uniqueInstance ifNil: [uniqueInstance := self basicNew initialize].
]

{ #category : #'accessing - instances and variables' }
SimpleNodeCounter class >> singleton [
	^ uniqueInstance 

]

{ #category : #initialization }
SimpleNodeCounter >> initialize [

	self reset.
	^ self
]

{ #category : #'as yet unclassified' }
SimpleNodeCounter >> newNode [

	value := value + 1.
	^ value - 1
]

{ #category : #'as yet unclassified' }
SimpleNodeCounter >> reset [

value := 1.
]
