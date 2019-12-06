" Vim syntax file
" Language: Zen
" Maintainer: Andrew Kelley
" Latest Revision: 03 August 2016

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "zen"

syn keyword zenStorage const var extern packed export pub noalias inline noinline comptime nakedcc stdcallcc volatile allowzero align linksection threadlocal vtable terminate
syn keyword zenStructure struct enum union error interface
syn keyword zenStatement break return continue asm defer errdefer unreachable try catch async noasync await suspend resume
syn keyword zenConditional if else switch and or orelse
syn keyword zenRepeat while for

syn keyword zenConstant null undefined
syn keyword zenKeyword fn usingnamespace test
syn keyword zenType bool f16 f32 f64 f128 void noreturn type anyerror anyframe
syn keyword zenType i0 u0 isize  usize comptime_int comptime_float
syn keyword zenType c_short c_ushort c_int c_uint c_long c_ulong c_longlong c_ulonglong c_longdouble c_void

syn keyword zenBoolean true false

syn match zenType "\v<[iu][1-9]\d*>"

syn match zenOperator display "\%(+%\?\|-%\?\|/\|*%\?\|=\|\^\|&\|?\||\|!\|>\|<\|%\|<<%\?\|>>\)=\?"
syn match zenArrowCharacter display "->"

syn match zenBuiltinFn "\v\@(addWithOverflow|ArgType|atomicLoad|bitCast|breakpoint)>"
syn match zenBuiltinFn "\v\@(alignCast|alignOf|cDefine|cImport|cInclude)>"
syn match zenBuiltinFn "\v\@(cUndef|canImplicitCast|clz|cmpxchgWeak|cmpxchgStrong|compileError)>"
syn match zenBuiltinFn "\v\@(compileLog|ctz|popCount|divExact|divFloor|divTrunc)>"
syn match zenBuiltinFn "\v\@(embedFile|export|tagName|TagType|errorName)>"
syn match zenBuiltinFn "\v\@(errorReturnTrace|fence|fieldParentPtr|field|unionInit)>"
syn match zenBuiltinFn "\v\@(frameAddress|import|inlineCall|newStackCall|asyncCall|intToPtr|IntType)>"
syn match zenBuiltinFn "\v\@(maxValue|memberCount|memberName|memberType)>"
syn match zenBuiltinFn "\v\@(memcpy|memset|minValue|mod|mulWithOverflow)>"
syn match zenBuiltinFn "\v\@(noInlineCall|bitOffsetOf|byteOffsetOf|OpaqueType|panic|ptrCast)>"
syn match zenBuiltinFn "\v\@(ptrToInt|rem|returnAddress|setCold|Type)>"
syn match zenBuiltinFn "\v\@(setRuntimeSafety|setEvalBranchQuota|setFloatMode)>"
syn match zenBuiltinFn "\v\@(setGlobalLinkage|setGlobalSection|shlExact|This|hasDecl|hasField)>"
syn match zenBuiltinFn "\v\@(shlWithOverflow|shrExact|sizeOf|sqrt|byteSwap|subWithOverflow|intCast|floatCast|intToFloat|floatToInt|boolToInt|errSetCast)>"
syn match zenBuiltinFn "\v\@(truncate|typeId|typeInfo|typeName|typeOf|atomicRmw|bytesToSlice|sliceToBytes)>"
syn match zenBuiltinFn "\v\@(intToError|errorToInt|intToEnum|enumToInt|setAlignStack|frame|Frame|frameSize|bitReverse|Vector)>"
syn match zenBuiltinFn "\v\@(sin|cos|exp|exp2|ln|log2|log10|fabs|floor|ceil|trunc|round)>"
syn match zenBuiltinFn "\v\@(mulAdd|Trap|alignedSizeOf|alignTo|)>"
syn match zenBuiltinFn "\v\@(atomicStore|is)>"

syn match zenDecNumber display "\<[0-9]\+\%(.[0-9]\+\)\=\%([eE][+-]\?[0-9]\+\)\="
syn match zenHexNumber display "\<0x[a-fA-F0-9]\+\%([a-fA-F0-9]\+\%([pP][+-]\?[0-9]\+\)\?\)\="
syn match zenOctNumber display "\<0o[0-7]\+"
syn match zenBinNumber display "\<0b[01]\+\%(.[01]\+\%([eE][+-]\?[0-9]\+\)\?\)\="


syn match zenCharacterInvalid display contained /b\?'\zs[\n\r\t']\ze'/
syn match zenCharacterInvalidUnicode display contained /b'\zs[^[:cntrl:][:graph:][:alnum:][:space:]]\ze'/
syn match zenCharacter /b'\([^\\]\|\\\(.\|x\x\{2}\)\)'/ contains=zenEscape,zenEscapeError,zenCharacterInvalid,zenCharacterInvalidUnicode
syn match zenCharacter /'\([^\\]\|\\\(.\|x\x\{2}\|u\x\{4}\|U\x\{6}\)\)'/ contains=zenEscape,zenEscapeUnicode,zenEscapeError,zenCharacterInvalid

syn region zenCommentLine start="//" end="$" contains=zenTodo,@Spell
syn region zenCommentLineDoc start="////\@!" end="$" contains=zenTodo,@Spell

" TODO: match only the first '\\' within the zenMultilineString as zenMultilineStringPrefix
syn match zenMultilineStringPrefix display contained /c\?\\\\/
syn region zenMultilineString start="c\?\\\\" end="$" contains=zenMultilineStringPrefix

syn keyword zenTodo contained TODO

syn match     zenEscapeError   display contained /\\./
syn match     zenEscape        display contained /\\\([nrt\\'"]\|x\x\{2}\)/
syn match     zenEscapeUnicode display contained /\\\(u\x\{4}\|U\x\{6}\)/
syn region    zenString      start=+c\?"+ skip=+\\\\\|\\"+ end=+"+ oneline contains=zenEscape,zenEscapeUnicode,zenEscapeError,@Spell

hi def link zenDecNumber zenNumber
hi def link zenHexNumber zenNumber
hi def link zenOctNumber zenNumber
hi def link zenBinNumber zenNumber

hi def link zenBuiltinFn Function
hi def link zenKeyword Keyword
hi def link zenType Type
hi def link zenCommentLine Comment
hi def link zenCommentLineDoc SpecialComment
hi def link zenTodo Todo
hi def link zenString String
hi def link zenMultilineString String
hi def link zenMultilineStringContent String
hi def link zenMultilineStringPrefix Comment
hi def link zenCharacterInvalid Error
hi def link zenCharacterInvalidUnicode zenCharacterInvalid
hi def link zenCharacter Character
hi def link zenEscape Special
hi def link zenEscapeUnicode zenEscape
hi def link zenEscapeError Error
hi def link zenBoolean Boolean
hi def link zenConstant Constant
hi def link zenNumber Number
hi def link zenArrowCharacter zenOperator
hi def link zenOperator Operator
hi def link zenStorage StorageClass
hi def link zenStructure Structure
hi def link zenStatement Statement
hi def link zenConditional Conditional
hi def link zenRepeat Repeat
