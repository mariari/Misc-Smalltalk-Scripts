"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  I am the baseline of MiscPharoScripts

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : 'BaselineOfMiscPharoScripts',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMiscPharoScripts-Baseline',
	#package : 'BaselineOfMiscPharoScripts',
	#tag : 'Baseline'
}

{ #category : 'baselines' }
BaselineOfMiscPharoScripts >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Deps"
		"self pharoFunctional: spec."
		"Programs"
		spec
			package: 'MiscPharoScripts';
			package: 'MiscPharoScriptsTests'
			with: [ spec requires: #( 'MiscPharoScripts' ) ] ]
]

{ #category : 'external projects' }
BaselineOfMiscPharoScripts >> pharoFunctional: spec [
"Do not load in any Pharo version newer than 9. This will brick your image"
	spec baseline: 'PharoFunctional' with: [
		spec
			repository: 'github://dvmason/Pharo-Functional:master';
			loads: 'default' ]
]
