"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestSimple,
	#superclass : #PackageManifest,
	#category : 'Simple-Manifest'
}

{ #category : #'code-critics' }
ManifestSimple class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SimpleNode #peephole #false)) #'2024-02-10T14:55:30.509365+08:00') #(#(#RGMethodDefinition #(#SimpleNode #at:isKind: #false)) #'2024-02-10T17:17:25.749353+08:00') #(#(#RGMethodDefinition #(#SimpleAddNode #compute #false)) #'2024-02-10T17:24:33.848392+08:00') #(#(#RGMethodDefinition #(#SimpleNode #computeBiOpNumberWith: #false)) #'2024-02-10T17:36:34.207846+08:00') #(#(#RGMethodDefinition #(#SimpleMinusNode #compute #false)) #'2024-02-10T18:15:13.879527+08:00') )
]
