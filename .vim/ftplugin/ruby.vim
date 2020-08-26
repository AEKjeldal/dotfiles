nmap <Tab> >>
nmap <S-Tab> <<

:compiler rspec

inoremap <buffer><silent> ;edo .each do \|CR><++><CR>end<esc>kk$F<"_df>i
inoremap <buffer><silent> ;map .map { \|<++>\| <++> }<esc>2F<df>i
imap  <C-l> <esc>/<++><cr>"_df>a
imap <buffer> å #{}<++><esc>4hi
imap <buffer> Å <C-o>ysiwB#<C-o>f}<C-o>l
map <buffer> <silent> å ysiwBF{i#

imap <buffer> <c-@> _

imap <buffer> æ [
imap <buffer> ø ]
imap <buffer> Æ {
imap <buffer> Ø }
setlocal tabstop=3 shiftwidth=3 expandtab " setting up tab behaviour

let b:specfile=substitute(expand("%:t:r"),"_spec","","")."_spec.rb"
let b:codefile=b:specfile

if b:specfile == expand("%:t")
   let b:codefile=substitute(expand("%:t:r"),"_spec","","").".rb"
else

endif

map <leader>1 :execute "find" b:codefile<cr>


"Surround marked with {} then remark it
vmap <buffer> { "tc{<C-R>t}<esc>gv 
nmap <buffer> <leader>m :execute "make" system("find . -name ".b:specfile)<cr>

 
