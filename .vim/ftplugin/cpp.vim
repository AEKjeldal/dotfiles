

:function! ToggleHeader()
let extention = expand('%:e')
if extention == 'cpp'
   :e %:r.h*
else
   :e %:r.c*
endif





endfunction

" Format everything in buffer and jump back to current line
map <buffer> <leader>0 mtgg=G`t 
map <buffer> <F3> :call ToggleHeader()<cr>
