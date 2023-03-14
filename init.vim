syntax enable
set number
set rnu
set mouse=a
set numberwidth=1
set clipboard=unnamedplus
set ruler
set showcmd
set showmatch
set encoding=utf-8
set sw=2
set laststatus=2
set noshowmode
set hidden
set termguicolors
set hlsearch
set incsearch
set ignorecase
set smartcase
set background=dark
set splitright

autocmd FileType cpp :call RunCpp()
autocmd FileType java :call RunJava()
autocmd FileType python :call RunPython()
autocmd FileType javascript :call RunJsAndTs()

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugins')

  Plug 'sheerun/vim-polyglot'
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdtree'
  Plug 'shinchu/lightline-gruvbox.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'preservim/nerdcommenter'
  Plug 'jiangmiao/auto-pairs'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', {'do': {-> fzf#install()}}

call plug#end()

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=1
highlight Normal ctermbg=NONE
colorscheme gruvbox

let g:lightline = {
  \ 'active': {
  \   'left': [['mode', 'paste'], [], ['relativepath', 'modified']],
  \   'right': [['kitestatus'], ['filetype', 'percent', 'lineinfo'], ['gitbranch']]
  \ },
  \ 'inactive': {
  \   'left': [['inactive'], ['relativepath']],
  \   'right': [['bufnum']]
  \ },
  \ 'component': {
  \   'bufnum': '%n',
  \   'inactive': 'inactive'
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head',
  \   'kitestatus': 'kite#statusline'
  \ },
  \ 'colorscheme': 'gruvbox',
  \ 'subseparator': {
  \   'left': '',
  \   'right': ''
  \}
\}

let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeWinPos='right'
let mapleader=' '

inoremap <C-c> <Esc>

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc> :w<CR>
nnoremap <C-q> :q!<CR>
inoremap <C-q> <Esc> :q!<CR>
nnoremap <C-w> :bdelete<CR>
nnoremap <C-n> :bnext<CR>

nnoremap <C-a> :%y+<CR>
nnoremap <Leader>e :NERDTreeToggle<CR>
nnoremap <F5> :so $MYVIMRC<CR>

nmap > 5<C-w>>
nmap < 5<C-w><
vmap < <gv
vmap > >gv
vmap K :m '<-2<CR>gv-gv
vmap J :m '>+1<CR>gv-gv
nmap n :m .-2<CR>==
nmap m :m .+1<CR>==

nnoremap <Leader>pi :PlugInstall<CR>
nnoremap <Leader>pc :PlugClean<CR>
nnoremap <Leader>pu :PlugUpdate<CR>
nnoremap <Leader>pp :PlugUpgrade<CR>

nnoremap <Leader>¿ :e ~/.config/nvim/init.vim<CR>
nnoremap <Leader>, $a;<Esc>

function! RunJava()
   imap <F2> <Esc> :w<CR> :!java % < inp<CR>
   nmap <F2> :w<CR> :!java % < inp<CR>
endfunction

function! RunCpp()
   imap <F2> <Esc> :w<CR> :!g++ -std=c++20 -DONPC -Wall -O2 -o "%<" "%" && ".//%<" < inp<CR>
   nmap <F2> :w<CR> :!g++ -std=c++20 -DONPC -Wall -O2 -o %< % && .//%< < inp<CR>
endfunction

function! RunPython()
   imap <F2> <Esc> :w<CR> :!python3 % < inp<CR>
   nmap <F2> :w<CR> :!python3 % < inp<CR>
endfunction

function! RunJsAndTs()
   imap <F2> <Esc> :w<CR> :!node %<CR>
   nmap <F2> :w<CR> :!node %<CR>
endfunction

function! OpenTerminal()
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"

  let bufNum = bufnr("%")
  let bufType = getbufvar(bufNum, "&buftype", "not found")
  if bufType == "terminal"
    execute "q"
  else
    execute "sp term://zsh"
    execute "set nonu"
    execute "set nornu"

    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!

    execute "tnoremap <buffer> <Esc> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q"
    execute "tnoremap <buffer> <C-7> <C-\\><C-\\><C-n>"
    startinsert!
  endif
endfunction

nnoremap <C-t> :call OpenTerminal()<CR>

nnoremap / <plug>NERDCommenterToggle
vnoremap / <plug>NERDCommenterToggle

nnoremap <silent><C-h> :TmuxNavigateLeft<CR>
nnoremap <silent><C-l> :TmuxNavigateRight<CR>
nnoremap <silent><C-j> :TmuxNavigateDown<CR>
nnoremap <silent><C-k> :TmuxNavigateUp<CR>
