if exists("g:zen_loaded")
  finish
endif
let g:zen_loaded = 1

function! s:fmt_autosave()
  if get(g:, "zen_fmt_autosave", 1)
    call zen#fmt#Format()
  endif
endfunction

augroup vim-zen
  autocmd!
  autocmd BufWritePre *.zen call s:fmt_autosave()
augroup end

" vim: sw=2 ts=2 et
