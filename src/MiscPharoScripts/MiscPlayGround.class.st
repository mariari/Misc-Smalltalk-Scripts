"
I represent various ideas of playing around with Pharo.

I know about random examples that are ran, it is best never to use me in real code, but to look at me for examples for playing with aspects.

Some examples include the playground of playing around with:

- Files
- Method resolutions
- Meta Knowledge
"
Class {
	#name : 'MiscPlayGround',
	#superclass : 'Object',
	#category : 'MiscPharoScripts',
	#package : 'MiscPharoScripts'
}

{ #category : 'API - files' }
MiscPlayGround class >> MethodResolver [

	"I represent some examples of resolving methods and classes"

	"scope: class-variables  &  class-instance-variables"

	|  |
	Integer methodNamed: #factorial.


(Integer>>#factorial)  class.

Integer >> #factorial .

^ SequenceableCollection  >> #reversed .
]

{ #category : 'API - files' }
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

{ #category : 'plotting' }
MiscPlayGround >> bestFitFor: xs and: ys [
	"I calculate the best fit for a given collection of x y data"

	"The formula for a line is y = a + bx
	where we are trying to find a and b that minimizes error
	S(a,b) = ∑(yi - (a +b * xi))²
	
	We want the slope at every line so we gather it by taking the derivative
	derivative for a and b  at 0 gives us 
	b = ∑(xi - xmean)(yi - ymean)/ ∑(xi - xmean)²
	therefore: a = ymean - bmean * x
	"
	| meanX meanY varX cov slope intercept xmin xmax y1 y2 |
	meanX := xs sum / xs size.
	meanY := ys sum / ys size.

	varX := (xs collect: [ :xi | (xi - meanX) squared ]) sum.
	cov := (xs with: ys collect: [ :xi :yi | (xi - meanX) * (yi - meanY) ])
		       sum.

	slope := varX = 0
		         ifTrue: [ 0.0 ]
		         ifFalse: [ cov / varX ].
	intercept := meanY - (slope * meanX).

	"endpoints for the fit line (in data space)"
	xmin := xs min.
	xmax := xs max.
	y1 := slope * xmin + intercept.
	y2 := slope * xmax + intercept.

	"plot it as a line-plot and add to the chart"
	^ RSLinePlot new x: { xmin . xmax } y: { y1. y2 }
]

{ #category : 'plotting' }
MiscPlayGround >> plotWithNormalizerLine [

	| x y z r c p fitPlot shapes |
	x := OrderedCollection new.
	y := OrderedCollection new.
	z := OrderedCollection new.
	r := Random seed: 42.
	1 to: 100 do: [ :i |
		x add: i + (r nextInteger: 10).
		y add: i + (r nextInteger: 10).
		z add: i + (r nextInteger: 10) ].

	c := RSCompositeChart new.
	p := RSScatterPlot new x: x y: y.

	fitPlot := self bestFitFor: x and: y.
	fitPlot
		color: Color red;
		width: 2.

	c add: p.

	c addDecoration: (RSHorizontalTick new doNotUseNiceLabel asFloat: 3).
	c addDecoration: RSVerticalTick new.

	c add: fitPlot.

	c build.
	shapes := p ellipses.
	shapes models: z.
	RSNormalizer size
		shapes: shapes;
		from: 2;
		to: 10;
		normalize: #yourself.
	RSNormalizer color
		shapes: shapes;
		normalize: #yourself.
	shapes translucent.
	^ c canvas
]
