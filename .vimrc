set nocompatible
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set nowrap
"set spell spelllang=en_us

call plug#begin('~/.vim/plugged')

"==============================General==============================
Plug 'vifm/vifm.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

Plug 'joereynolds/gtags-scope'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'justinmk/vim-sneak'

Plug 'itchyny/lightline.vim'

Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-signify' 

"========================Syntax/General-Programming====================
"Plug 'vim-syntastic/syntastic'
"Plug 'w0rp/ale'
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"==============================RUBY==============================
Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'tmhedberg/matchit'

"===================Markdown================================
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"==================C++ Stuff================================
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'vim-scripts/c.vim'
"==================Vimux==============================
Plug 'benmills/vimux'

"==================Tim Pope===========================
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'

"==================Colorschemes=======================
Plug 'tomasr/molokai'
Plug 'crusoexia/vim-monokai'
Plug 'morhetz/gruvbox'
Plug 'dikiaap/minimalist'

call plug#end()
filetype plugin indent on    
"==================General Settings Start==============="
syntax on
set path+=**
set wildmenu 
set cindent
set rnu
set cursorline
hi CursorLine ctermbg=8 ctermfg=15 "8 = dark gray, 15 = white
set sw=3
set ts=3 
set expandtab
set number
set autoindent
set smartindent
set showmatch
set incsearch
set undofile
set undolevels=10000
set undodir=~/.vim/undodir
set t_Co=256
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
set mouse=a
set mousehide
let g:rehash256 = 1 "Put these two lines before assigning colorscheme
let g:molokai_original = 0
set background=dark
colorscheme monokai
"set rtp+=~/.vim/custom/misspellings.vim
"colorscheme gruvbox
"====================VimteX Settings==================
"let g:vimtex_view_general_viewer
"\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
"let g:vimtex_view_general_options = '-r @line @pdf @tex' 
"let g:tex_flavor = "latex" "treat .tex files as latex files (not plaintex) 
"set omnifunc=ccomplete#Complete
"============================Autocomands===============
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp map <buffer> <silent> <C-k> :call CurtineIncSw()<CR>
au BufNewFile,Bufread,BufEnter *.py noremap <silent> <buffer> <leader>m  :call VimuxRunCommandInDir('python2',1)<CR>
au BufNewFile,Bufread,BufEnter *.m noremap <buffer> <leader>m  :call VimuxRunCommand(expand('%:r'))<CR>

autocmd FileType ruby setlocal omnifunc=LanguageClient#complete
autocmd Filetype ruby set softtabstop=3
autocmd Filetype ruby set sw=3
autocmd Filetype ruby set ts=3
"autocmd CursorHold * silent call CocActionAsync('highlight')

map <buffer> <silent> <C-k> :call CurtineIncSw()<CR>

nmap <F2> <Plug>(coc-rename)
"nnoremap <silent> <C-p>  :<C-u>CocList -I symbols<cr>
"nmap <silent> gd <Plug>(coc-definition)

function MakeExecuteable()
	if getline(1) =~ "^#!.*/bin/"
		silent !chmod +x %
	endif
endfunction

au BufWritePost *.* call MakeExecuteable()

"let g:ale_max_signs=10
"let g:ale_cache_executable_check_failures = 0
"let g:ale_enable =0

let g:coc_disable_startup_warning = 1
let g:coc_global_extensions = ['coc-solargraph']

" let g:ale_fixers = {
" \    'ruby': ['rubocop'],
" \}

" let g:ale_fix_on_save = 0

let ruby_spellcheck_strings = 1

" ======== Gutentags ===========

set cscopetag "search both cscopes db and the tags file
"let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_modules = ['ctags']
let g:gutentags_project_root = ['.svn','.git']
"let g:gutentags_cache_dir = expand('~/.cache/tags')


"=================Mappings========================
let mapleader = "\<Space>"
"Jump 15 lines when holding shift

"==================Window=Navigation========================
map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>h <C-W>h
map <leader>l <C-W>l

map <leader>H <C-W>H
map <leader>J <C-W>J
map <leader>K <C-W>K
map <leader>L <C-W>L

map <leader>v :vsplit<CR>
map <leader>s :split<CR>

"==================Project=Navigation========================


nmap <C-p> :FZF<CR>
nmap <C-f> :Rg<CR>

nmap <C-t> :Tags<CR>

nmap <C-b> :Vifm<cr>


map <leader>w :w<cr>

"==================File=Navigation========================
nmap K {
nmap J }

"navigate buffers
map <leader>1 :bp<CR>
map <leader>2 :bn<CR>

"===============Vim Configuration==========================
map <leader>½ :source ~/.vimrc<CR>
map <leader>3 :e ~/.vim/ftplugin/%:e.vim<CR>

"close buffer
map <leader>x :x<CR>

" cteate splits

nmap <Tab> >>
nmap <S-Tab> <<

map å ``t:call setreg('t',[])<CR>

" go file
"map gf :e <cfile><CR>
" go tag
map gt <C-]> 

" Indention in visual mode keeps selection
map  ½ $
"========= INSERT ==========
imap ½ $
"========= VISUAL ===========

vmap ½ $

xnoremap <S-Tab> < gv
xnoremap <Tab> > gv
xnoremap < <gv
xnoremap > >gv

" change surroundings of visual
vmap " c"<C-r>""<esc>gv
vmap ( c(<C-r>")<esc>gv
vmap { c{<C-r>"}<esc>gv
vmap [ c[<C-r>"]<esc>gv


"======================== Fugitive =============================
nmap <leader>gs :G<CR>
nmap <leader>gc :Gw<CR>:Gcommit<cr>




"======================== TMUX STUFF =============================
let g:runmode=0
let g:runEnv=0
let g:runCmd ="make"
let g:tmuxRunWin ="work"
let g:runEnv=""

function! SetRunEnv()
   if g:runEnv=="cmd.exe /c "
      let g:runEnv=""
   else 
      let g:runEnv="cmd.exe /c "
   endif
endfunction

map <silent> <F8> :call SetRunEnv()<cr>

function! SetRunMode()
   if !g:runmode
      let g:runmode=1
   else
      let g:runmode=0
   endif
endfunction

function! TmuxCreateTab(tabname)
   if !system("tmux list-window | grep ".a:tabname)
      call system ("tmux new-window -n ".a:tabname." -d")
   endif
endfunction

function! TmuxSendCmdToTab(cmd)
   call TmuxCreateTab(g:tmuxRunWin)
   call system("tmux send-keys -t $session:".g:tmuxRunWin." '".g:runEnv.a:cmd."' C-m")
endfunction

fun! GetFuncName(prefix)
   let funLine = search(a:prefix.' \w\+','bn')
   try
      return matchlist(getline(funLine),a:prefix.' \(\w\+\)')[1]
   catch
      return ""
   endtry
endfun

"=========================-Statusline-=======================

fun! LightLineMode()
   try
      :call exists(b:runMode)
      return b:runMode
   catch
      return "N/A"
   endtry
   "if exists(b:runMode)
"else 
endfun


let b:content="N/A"
let g:lightline = {
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '' },
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'gitbranch','fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

