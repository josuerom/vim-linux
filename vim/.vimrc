" @author: josuerom @date: 07/02/23
set runtimepath+=~/.vim_runtime
source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim
try
  source ~/.vim_runtime/my_configs.vim
catch
endtry

syntax enable
set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
set showcmd
set ruler
set encoding=utf-8
set sw=2
set laststatus=2
set noshowmode

autocmd FileType cpp :call RunCpp()
autocmd FileType java :call RunJava()
autocmd FileType py :call RunPython()
autocmd FileType js :call RunJsAndTs()
autocmd FileType ts :call RunJsAndTs()

call plug#begin('~/.config/vim/plugins')

Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'

call plug#end()

colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let g:deoplete#enable_at_startup=1
let g:jsx_ext_required=0

let mapleader = " "

nmap <Leader>w :w!<CR>
imap <C-s> <Esc> :w!<CR>
nmap <Leader>q :q!<CR>
imap <C-q> <Esc> :q!<CR>

imap <C-c> <Esc>
nmap > 5<C-w>>
nmap < 5<C-w><

nmap <F3> :%y+<CR>
nmap <Leader>e :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

nmap <C-t> :terminal<CR> :resize 13<CR>
nmap <C-l> :bnext<CR>
nmap <C-d> :bdelete<CR>

vmap < <gv
vmap > >gv
nmap n :m .-2<CR>==
nmap m :m .+1<CR>==

nmap <Leader>pi :PlugInstall<CR>
nmap <Leader>pc :PlugClean<CR>
nmap <Leader>pu :PlugUpdate<CR>
nmap <Leader>pp :PlugUpgrade<CR>

function! RunJava()
   imap <F2> <Esc> :w<CR> :!java % && < inp<CR>
   nmap <F2> :w<CR> :!java % && < inp<CR>
endfunction

function! RunCpp()
   imap <F2> <Esc> :w<CR> :!g++ -std=c++20 -Wall -O2 -o "%<" "%" && "./%<" < inp<CR>
   nmap <F2> <Esc> :w<CR> :!g++ -std=c++20 -Wall -O2 -o %< % && ./%< < inp<CR>
endfunction

function! RunPython()
   imap <F2> <Esc> :w<CR> :!python % && < inp<CR>
   nmap <F2> :w<CR> :!python % && < inp<CR>
endfunction

function! RunJsAndTs()
   imap <F2> <Esc> :w<CR> :!node %<CR>
   nmap <F2> :w<CR> :!node %<CR>
endfunction
