" Adapted from fatih/vim-go: autoload/go/list.vim
"
" Copyright 2011 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.
"

" Window opens the list with the given height up to 10 lines maximum.
" Otherwise g:zen_loclist_height is used.
"
" If no or zero height is given it closes the window by default.
" To prevent this, set g:zen_list_autoclose = 0
function! zen#list#Window(listtype, ...) abort
  " we don't use lwindow to close the location list as we need also the
  " ability to resize the window. So, we are going to use lopen and lclose
  " for a better user experience. If the number of errors in a current
  " location list increases/decreases, cwindow will not resize when a new
  " updated height is passed. lopen in the other hand resizes the screen.
  if !a:0 || a:1 == 0
    call zen#list#Close(a:listtype)
    return
  endif

  let height = zen#config#ListHeight()
  if height == 0
    " prevent creating a large location height for a large set of numbers
    if a:1 > 10
      let height = 10
    else
      let height = a:1
    endif
  endif

  if a:listtype == "locationlist"
    exe 'lopen ' . height
  else
    exe 'copen ' . height
  endif
endfunction


" Get returns the current items from the list
function! zen#list#Get(listtype) abort
  if a:listtype == "locationlist"
    return getloclist(0)
  else
    return getqflist()
  endif
endfunction

" Populate populate the list with the given items
function! zen#list#Populate(listtype, items, title) abort
  if a:listtype == "locationlist"
    call setloclist(0, a:items, 'r')

    " The last argument ({what}) is introduced with 7.4.2200:
    " https://github.com/vim/vim/commit/d823fa910cca43fec3c31c030ee908a14c272640
    if has("patch-7.4.2200") | call setloclist(0, [], 'a', {'title': a:title}) | endif
  else
    call setqflist(a:items, 'r')
    if has("patch-7.4.2200") | call setqflist([], 'a', {'title': a:title}) | endif
  endif
endfunction

" Parse parses the given items based on the specified errorformat and
" populates the list.
function! zen#list#ParseFormat(listtype, errformat, items, title) abort
  " backup users errorformat, will be restored once we are finished
  let old_errorformat = &errorformat

  " parse and populate the location list
  let &errorformat = a:errformat
  try
    call zen#list#Parse(a:listtype, a:items, a:title)
  finally
    "restore back
    let &errorformat = old_errorformat
  endtry
endfunction

" Parse parses the given items based on the global errorformat and
" populates the list.
function! zen#list#Parse(listtype, items, title) abort
  if a:listtype == "locationlist"
    lgetexpr a:items
    if has("patch-7.4.2200") | call setloclist(0, [], 'a', {'title': a:title}) | endif
  else
    cgetexpr a:items
    if has("patch-7.4.2200") | call setqflist([], 'a', {'title': a:title}) | endif
  endif
endfunction

" JumpToFirst jumps to the first item in the location list
function! zen#list#JumpToFirst(listtype) abort
  if a:listtype == "locationlist"
    ll 1
  else
    cc 1
  endif
endfunction

" Clean cleans and closes the location list
function! zen#list#Clean(listtype) abort
  if a:listtype == "locationlist"
    lex []
  else
    cex []
  endif

  call zen#list#Close(a:listtype)
endfunction

" Close closes the location list
function! zen#list#Close(listtype) abort
  let autoclose_window = zen#config#ListAutoclose()
  if !autoclose_window
    return
  endif

  if a:listtype == "locationlist"
    lclose
  else
    cclose
  endif
endfunction

function! s:listtype(listtype) abort
  let listtype = zen#config#ListType()
  if empty(listtype)
    return a:listtype
  endif

  return listtype
endfunction

" s:default_list_type_commands is the defaults that will be used for each of
" the supported commands (see documentation for g:zen_list_type_commands). When
" defining a default, quickfix should be used if the command operates on
" multiple files, while locationlist should be used if the command operates on a
" single file or buffer. Keys that begin with an underscore are not supported
" in g:zen_list_type_commands.
let s:default_list_type_commands = {
      \ "ZenFmt":                "locationlist",
  \ }

function! zen#list#Type(for) abort
  let l:listtype = s:listtype(get(s:default_list_type_commands, a:for))
  if l:listtype == "0"
    call zen#util#EchoError(printf(
          \ "unknown list type command value found ('%s'). Please open a bug report in the zen.vim repo.",
          \ a:for))
    let l:listtype = "quickfix"
  endif

  return get(zen#config#ListTypeCommands(), a:for, l:listtype)
endfunction

" vim: sw=2 ts=2 et