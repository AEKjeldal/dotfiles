nmap <Tab> >>
nmap <S-Tab> <<

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




let b:runfile ="run.bat"

let g:workingPath=system("pwd")
let g:runfileloc=system("find . -name ".b:runfile."|head -1")
let g:runPath=fnamemodify(g:runfileloc,':h')

function! ToggleTest()
   call SetRunCmd()
   if g:runmode
      call TmuxSendCmdToTab("cd ".g:workingPath)
   else
      call TmuxSendCmdToTab("cd ".g:runPath)
  endif
endfunction

function! SetRunCmd()
   call SetRunMode()
   if g:runmode
      let g:runCmd="rspec "
   else
      let g:runCmd="run.bat"
   endif
endfunction

call SetRunCmd()


map <buffer> <silent> <F7> :call ToggleTest()<cr>

let b:runList_idx = 0
let b:runList = ["rspec spec/**/".b:specfile,"run.bat","ruby ".expand("%")]
function! ToggleRunList()
   if b:runList_idx >= len(b:runList)-1
      let b:runList_idx = 0
   else
      let b:runList_idx = b:runList_idx + 1
   endif
   echo b:runList[b:runList_idx]
endfunction

function! StartCommand()
   if g:runmode
      call TmuxSendCmdToTab(g:runCmd."spec/**/".b:specfile)
      call system("tmux select-window -t $session:work")
   else
      call TmuxSendCmdToTab(g:runCmd)
      "call TmuxSendCmdToTab("cmd.exe /c ".g:runCmd)
      "call system("tmux send-keys -t $session:work 'cmd.exe /c ".g:runCmd."' C-m")
   endif
endfunction

"Surround marked with {} then remark it
vmap <buffer> { "tc{<C-R>t}<esc>gv 
nmap <buffer> <leader>m :call StartCommand()<CR>
