"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestSimple',
	#superclass : 'PackageManifest',
	#category : 'Simple-Manifest',
	#package : 'Simple',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestSimple class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SimpleNode #peephole #false)) #'2024-02-10T14:55:30.509365+08:00') )
]
