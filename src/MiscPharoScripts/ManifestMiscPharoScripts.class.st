"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestMiscPharoScripts',
	#superclass : 'PackageManifest',
	#category : 'MiscPharoScripts-Manifest',
	#package : 'MiscPharoScripts',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestMiscPharoScripts class >> ruleLongMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MiscPlayGround #plotWithNormalizerLine #false)) #'2025-10-17T22:18:08.003382+08:00') )
]
