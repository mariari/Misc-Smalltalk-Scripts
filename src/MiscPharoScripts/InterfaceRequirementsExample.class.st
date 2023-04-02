Class {
	#name : #InterfaceRequirementsExample,
	#superclass : #Object,
	#traits : 'TSetArithmetic',
	#classTraits : 'TSetArithmetic classTrait',
	#category : #MiscPharoScripts
}

{ #category : #'tests - set arithmetic' }
InterfaceRequirementsExample >> testDifferenceWithSeparateCollection [

	"Answer the set theoretic difference of two collections."

	| res separateCol foo |



	^ self subclassResponsibility
]
