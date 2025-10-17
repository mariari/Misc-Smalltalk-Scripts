"
I Represent Pharo Information that can be found on the system.

I know certain information about the system and wish to share it with others

I am implemented by Mariari

- pharoLOC

```
PharoInfo PharoLOC
```
"
Class {
	#name : 'PharoInfo',
	#superclass : 'Object',
	#category : 'MiscPharoScripts',
	#package : 'MiscPharoScripts'
}

{ #category : 'infos' }
PharoInfo class >> PharoLOC [

	"Checking the LOC in the entire Pharo Image"

	^ SmalltalkImage current allClasses
		  inject: 0
		  into: [ :sum :each | sum + each linesOfCode ]
]
