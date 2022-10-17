"
A String is an indexed collection of Characters. Class String provides the abstract super class for ByteString (that represents an array of 8-bit Characters) and WideString (that represents an array of  32-bit characters).  In the similar manner of LargeInteger and SmallInteger, those subclasses are chosen accordingly for a string; namely as long as the system can figure out so, the String is used to represent the given string.

Strings support a vast array of useful methods, which can best be learned by browsing and trying out examples as you find them in the code.

## Substrings and slicing

A number of selectors can be used to get substrings. `String>>#lines` will return a colection containing substrings separated by `\\n`, `\\r`, or `\\r\\n`; `String>>#trim` will return a substring with whitespace removed from the beginning and end. 

Obtaining parts of a string can also be achieved using numbered indices, also known as slicing. There are shortcut methods for some common operations that are often inherited from `SequenceableCollection` inclusing `allButFirst`, `allButLast`, `first`, or `last`.

```
s := 'abcdefg'.

s first. ""$a""
s allButFirst.  ""bcdefg""

s last.  ""$g""
s allButLast.  ""abcdef""

""pass a number argument to change the number of characters removed/kept""

s first: 2.  ""ab""  
s allButFirst: 2.  ""cdefg""

s last: 2.  ""fg""
s allButLast: 2.  ""abcde""
```

To get the middle of a string use `SequenceableCollection>>#copyFrom:to:`

```
s := 'abcdefg'.
s copyFrom: 2 to: 6. ""bcdef""
```

To count back from the end of the string use the `size` selector
```
s := 'abcdefg'
s copyFrom: 2 to: s size - 1 
```

## Formatting

Strings have a `String>>#format:` selector that can be used for interpolating other objects.
The ""string template"" can either have numbers between curly bracket characters (`{` and `}`)
where the argument to format is a collection where values are indexed by number. Or pass in
a `HashedCollection` where the placeholders are the keys of the collection
```
'ab {1} ef {2}' format: {'cd'. 'gh'}.  ""ab cd ef gh""

'ab {one} ef {two}' format: 
    (Dictionary with: #one -> 'cd' with: #two -> 'gh').
```

`String>>#contractTo:` is also useful for shortening strings to a particular length by replacing 
middle characters.

## Copying and Streaming
As well as the `format:` selector it is possible to build up a string using contatenation with
`SequenceableCollection>>#,` 

```
a := 'abc'.
b := ' easy as '.
c := '123'.
a , b , c.  ""abc easy as 123""
```
Or alternatively, construct a string from a stream using `SequenceableCollection class>>#streamContents:`.

```
s := String streamContents: [ :stream |
	  stream nextPutAll: 'abcdefg';
	  space;
	  nextPutAll: '123456';
	  space.
	  '7890' putOn: stream. ].  ""abcdefg 123456 7890""
```

## Finding/Searching

Simple reqular expression type searching can be performed using `String>>#match:`, which has similar
symantics as ""globbing"" in a shell. The reciever is a template string where the `#` character matches any single character and the `*` character matches any number of characters. A `Boolean` object is returned. 
```
'#abb*cdch' match: '4abbadskfakjdfadiadfnvcdch'  ""true""
```

For more complex matching use `String>>#matchesRegex:` which is an extension method implmented by `RxMatcher`. See the help documentation on regular expressions `HelpBrowser openOn: RegexHelp.`

"
Class {
	#name : #String,
	#superclass : #ArrayedCollection,
	#classVars : [
		'AsciiOrder',
		'CSLineEnders',
		'CSNonSeparators',
		'CSSeparators',
		'CaseInsensitiveOrder',
		'CaseSensitiveOrder',
		'LowercasingTable',
		'Tokenish',
		'TypeTable',
		'UppercasingTable'
	],
	#category : #'Collections-Strings-Base'
}

{ #category : #'mathematical functions' }
String >> isPalendrome [
	^ self = self reverse .
]
