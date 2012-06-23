" rtf_highlight.vim
" Vagmi Mudumbai <vagmi at dharanasoft dot com>
" Adapted by Phillip Mates to work with linux
" License
" This program is free software. It comes without any warranty, to
" the extent permitted by applicable law. You can redistribute it
" and/or modify it under the terms of the Do What The Fuck You Want
" To Public License, Version 2, as published by Sam Hocevar. See
" http://sam.zoy.org/wtfpl/COPYING for more details. */



" This plugin uses the bad ass RTF Syntax Highlighter aptly titled 'highlight'
" Get highlight from http://www.andre-simon.de/doku/highlight/en/highlight.html

" setup a few variables
if !exists('g:rtfh_theme')
  let g:rtfh_theme = 'bipolar'
end
if !exists('g:rtfh_font')
  let g:rtfh_font = 'Menlo'
end
if !exists('g:rtfh_size')
  let g:rtfh_size = '24'
end

" the awesomeness
function! RTFHighlight(line1,line2,...)
  if !executable('highlight')
    echoerr "Bummer! highlight not found."
    return
  endif

  call writefile(getline(a:line1,a:line2), "/tmp/vim.highlight.xxx")
  let hcommand = "highlight --syntax " . a:1 . " -s " . g:rtfh_theme . " -k " . g:rtfh_font . " -K " . g:rtfh_size . " /tmp/vim.highlight.xxx 2>/dev/null"
  let output = system(hcommand)
  " send to selected (middle mouse click), for clipboard replace -i below with --clipboard
  let retval = system("xsel -i",output)
endfunction

" map it to a command
command! -nargs=1 -range=% RTFHighlight :call RTFHighlight(<line1>,<line2>,<f-args>)
