"=============================================================================
" FILE: syntax/snippet.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>(Modified)
" Last Modified: 25 Jul 2010
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

if version < 700
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn region  SnippetPrevWord             start=+'+ end=+'+ contained
syn region  SnippetPrevWord             start=+"+ end=+"+ contained
syn region  SnippetEval                 start=+`+ end=+`+ contained
syn match   SnippetWord                 '^\s\+.*$' contains=SnippetEval,SnippetExpand
syn match   SnippetExpand               '\${\d\+\%(:.\{-}\)\?\\\@<!}' contained
syn match   SnippetVariable             '\$\d\+' contained
syn match   SnippetComment              '^#.*$'

syn match   SnippetKeyword              '^\%(include\|snippet\|abbr\|prev_word\|delete\|alias\)' contained
syn match   SnippetPrevWords            '^prev_word\s\+.*$' contains=SnippetPrevWord,SnippetKeyword
syn match   SnippetStatementName        '^snippet\s.*$' contains=SnippetName,SnippetKeyword
syn match   SnippetName                 '\s\+.*$' contained
syn match   SnippetStatementAbbr        '^abbr\s.*$' contains=SnippetAbbr,SnippetKeyword
syn match   SnippetAbbr                 '\s\+.*$' contained
syn match   SnippetStatementRank        '^rank\s.*$' contains=SnippetRank,SnippetKeyword
syn match   SnippetRank                 '\s\+\d\+$' contained
syn match   SnippetStatementInclude     '^include\s.*$' contains=SnippetInclude,SnippetKeyword
syn match   SnippetInclude              '\s\+.*$' contained
syn match   SnippetStatementDelete      '^delete\s.*$' contains=SnippetDelete,SnippetKeyword
syn match   SnippetDelete               '\s\+.*$' contained
syn match   SnippetStatementAlias       '^alias\s.*$' contains=SnippetAlias,SnippetKeyword
syn match   SnippetAlias                '\s\+.*$' contained

hi def link SnippetKeyword Statement
hi def link SnippetPrevWord String
hi def link SnippetName Identifier
hi def link SnippetAbbr Normal
hi def link SnippetEval Type
hi def link SnippetWord String
hi def link SnippetExpand Special
hi def link SnippetVariable Special
hi def link SnippetComment Comment
hi def link SnippetInclude PreProc
hi def link SnippetDelete PreProc
hi def link SnippetAlias Identifier

let b:current_syntax = "snippet"
" Syntax highlighting for snippet files (used for snipMate.vim)
" Hopefully this should make snippets a bit nicer to write!
syn match snipComment '^#.*'
syn match placeHolder '\${\d\+\(:.\{-}\)\=}' contains=snipCommand
syn match tabStop '\$\d\+'
syn match snipCommand '`.\{-}`'
syn match snippet '^snippet.*' transparent contains=multiSnipText,snipKeyword
syn match multiSnipText '\S\+ \zs.*' contained
syn match snipKeyword '^snippet'me=s+8 contained
syn match snipError "^[^#s\t].*$"

hi link snipComment   Comment
hi link multiSnipText String
hi link snipKeyword   Keyword
hi link snipComment   Comment
hi link placeHolder   Special
hi link tabStop       Special
hi link snipCommand   String
hi link snipError     Error
