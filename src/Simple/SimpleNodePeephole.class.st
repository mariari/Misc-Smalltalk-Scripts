"
I turn on or off peephole optimization for the SoN Compiler
"
Class {
	#name : #SimpleNodePeephole,
	#superclass : #Object,
	#instVars : [
		'enable'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Simple-Base'
}

{ #category : #'class initialization' }
SimpleNodePeephole class >> initialize [
	"Upon loading a class, this selector is not looked up.
	If you want a class to be initialized upon loading, this class should define the selector #intialize explicitly"

	uniqueInstance ifNil: [uniqueInstance := self basicNew initialize].
]

{ #category : #'accessing - instances and variables' }
SimpleNodePeephole class >> singleton [
	^ uniqueInstance
]

{ #category : #creation }
SimpleNodePeephole >> disable [

	enable := false
]

{ #category : #creation }
SimpleNodePeephole >> enable [

	enable := true
]

{ #category : #initialization }
SimpleNodePeephole >> initialize [

	self enable.
	^ self
]

{ #category : #testing }
SimpleNodePeephole >> isDisabled [


^ enable not
]
