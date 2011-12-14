" Vim filetype plugin
" Language:   jade
" Author:     Naoyuki ABE <plasticscafe@gmail.com>
" Last Change: 2011 Dec 8

if !exists('g:jade_autocompile')
  let g:jade_autocompile = 0
endif
if !exists('g:jade_compress')
  let g:jade_compress = 0
endif
if system('which jade') != ''
autocmd BufWritePost,BufEnter *.jade call s:auto_jade_compile()
function! s:auto_jade_compile() " {{{
if g:jade_compress != 0 
  let compress_option = ' '
else 
  let compress_option = ' -o {pretty:true} '
endif
if g:jade_autocompile != 0
  try
    let html_name = expand("%:r") . ".html"  
    let jade_name = expand("%")  
    if filereadable(html_name) || 0 < getfsize(jade_name)
      silent execute ':!jade ' . compress_option . jade_name . ' 1> /dev/null 2>&1' 
      let jade_date = system('date -r ' . jade_name . ' +%s') 
      let html_date = system('date -r ' . html_name . ' +%s') 
      if !filereadable(html_name) || html_date < jade_date
        highlight StatusLine ctermfg=Red
      else
        highlight StatusLine ctermfg=none 
      endif
    endif
  endtry
endif
endfunction " }}}
endif

