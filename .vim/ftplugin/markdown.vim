
"map <leader>md 

setlocal spell

function! Find_pictures()
   let b:search_dirs="/mnt/c/Users/aek/Pictures"
   echo system("ls -1t /mnt/c/Users/aek/Pictures |head -1")
endfunction

" Normal mode bindings
nmap <buffer> <leader>f mm[s1z=´m


" Insert mode bindings
imap <buffer> ;link [](<++>)<esc>F[i


function! ToPresentation()
   call system("pandoc ".expand("%")." -t beamer -o ".expand("%:r")."_presentation.pdf")
endfunction


function! ToggleFormat()
   call SetRunMode()
   if g:runmode
      let g:runCmd="docx"
   else
      let g:runCmd="pdf"
  endif
   echo "Run Command Changed: ".g:runCmd
endfunction

call ToggleFormat()
nmap <buffer> <F7> :call ToggleFormat()<cr>


function! SaveAsDoc(format)
"let b:save_file=expand("%:r").".docx"
let b:save_file=expand("%:r").".".a:format
:call system("pandoc ".expand("%")." -s -o ".b:save_file." &")
endfunction

au BufWritePost *.md :call SaveAsDoc(g:runCmd)

let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_disabled = 1

vmap <C-b> di**<C-r>"**<esc>gv
vmap <C-i> di*<C-r>"*<esc>gv

