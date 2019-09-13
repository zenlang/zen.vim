function! zen#config#ListTypeCommands() abort
  return get(g:, 'zen_list_type_commands', {})
endfunction

function! zen#config#ListType() abort
  return get(g:, 'zen_list_type', '')
endfunction

function! zen#config#ListAutoclose() abort
  return get(g:, 'zen_list_autoclose', 1)
endfunction

function! zen#config#ListHeight() abort
  return get(g:, "zen_list_height", 0)
endfunction

function! zen#config#FmtAutosave() abort
  return get(g:, "zen_fmt_autosave", 0)
endfunction

function! zen#config#SetFmtAutosave(value) abort
  let g:zen_fmt_autosave = a:value
endfunction

function! zen#config#FmtCommand() abort
  return get(g:, "zen_fmt_command", ['zen', 'fmt', '--color', 'off'])
endfunction

function! zen#config#FmtFailSilently() abort
  return get(g:, "zen_fmt_fail_silently", 0)
endfunction

function! zen#config#FmtExperimental() abort
  return get(g:, "zen_fmt_experimental", 0)
endfunction

function! zen#config#Debug() abort
  return get(g:, 'zen_debug', [])
endfunction
