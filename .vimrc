" author: josuerom @date: 07/02/23
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
set rnu
set mouse=a
set numberwidth=1
set clipboard=unnamed
set showcmd
set showmatch
set ruler
set encoding=utf-8
set sw=3
set laststatus=2
set noshowmode
set background=dark

autocmd FileType cpp :call RunCpp()
autocmd FileType java :call RunJava()
autocmd FileType py :call RunPython()
autocmd FileType js :call RunJsAndTs()

call plug#begin('~/.config/vim/plugins')

   Plug 'sheerun/vim-polyglot'
   Plug 'morhetz/gruvbox'
   Plug 'shinchu/lightline-gruvbox.vim'
   Plug 'itchyny/lightline.vim'
   Plug 'scrooloose/nerdtree'
   Plug 'ryanoasis/vim-devicons'
   Plug 'easymotion/vim-easymotion'
   Plug 'christoomey/vim-tmux-navigator'
   Plug 'neoclide/coc.nvim', {'branch': 'release'}
   Plug 'terryma/vim-multiple-cursors'
   Plug 'preservim/nerdcommenter'
   Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
   Plug 'junegunn/fzf.vim'
   Plug 'jiangmiao/auto-pairs'
   Plug 'yggdroot/indentline'

call plug#end()

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic = 1
highlight Normal ctermbg = NONE
colorscheme gruvbox

let mapleader = " "

nmap <C-s> :w<CR>
imap <C-s> <Esc> :w<CR>
nmap <C-q> :q!<CR>
imap <C-q> <Esc> :q!<CR>

imap <C-c> <Esc>
nmap > 50<C-w>>
nmap < 50<C-w><

nmap <C-a> :%y+<CR>
nmap <Leader>e :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeWinPos='right'

nmap <Leader>l :bnext<CR>
nmap <Leader>dl :bdelete<CR>

vmap < <gv
vmap > >gv
nmap n :m .-2<CR>==
nmap m :m .+1<CR>==
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

nmap <Leader>pi :PlugInstall<CR>
nmap <Leader>pc :PlugClean<CR>
nmap <Leader>pu :PlugUpdate<CR>
nmap <Leader>pp :PlugUpgrade<CR>

function! RunJava()
   imap <F2> <Esc> :w<CR> :!java % < ~/workspace/sample/input<CR>
   nmap <F2> :w<CR> :!java % < ~/workspace/sample/input<CR>
   nmap <F3> :w<CR> :terminal %<CR>ils -a<CR>java 
endfunction

function! RunCpp()
   imap <F1> <Esc> :w<CR> :!g++ -std=c++20 -Djosuerom -Wall -Wextra -Wpedantic -Werror -fsanitize=address % -o ~/workspace/build/sol.out<CR>
   nmap <F1> :w<CR> :!g++ -std=c++20 -Djosuerom -Wall -Wextra -Wpedantic -Werror -fsanitize=address % -o ~/workspace/build/sol.out<CR>

   imap <F2> <Esc> :w<CR> :!~/workspace/build/sol.out < ~/workspace/sample/input<CR>
   nmap <F2> :w<CR> :!~/workspace/build/sol.out < ~/workspace/sample/input<CR>
   nmap <F3> :w<CR> :terminal ~/workspace/build/<CR>isol.out<CR> 
endfunction

function! RunPython()
   imap <F2> <Esc> :w<CR> :!python3 % < ~/workspace/sample/input<CR>
   nmap <F2> :w<CR> :!python3 % < ~/workspace/sample/input<CR>
   nmap <F3> :w<CR> :terminal %<CR>ils -a<CR>python3 
endfunction

function! RunJsAndTs()
   imap <F1> <Esc> :w<CR> :!node %<CR>
   nmap <F1> :w<CR> :!node %<CR>

   imap <F2> <Esc> :w<CR> :!node % < ~/workspace/sample/input<CR>
   nmap <F2> :w<CR> :!node % < ~/workspace/sample/input<CR>
   nmap <F3> :w<CR> :terminal %<CR>ils -a<CR>node 
endfunction

function! OpenTerminal()
   execute "normal \<C-l>"
   execute "normal \<C-l>"
   execute "normal \<C-l>"
   execute "normal \<C-l>"

   let bufNum = bufnr("%")
   let bufType = getbufvar(bufNum, "&buftype", "not found")

   if bufType == "terminal"
     execute "q"
   else
     execute "sp term://bash"
     execute "set nonu"
     execute "set nornu"

     silent au BufLeave <buffer> stopinsert!
     silent au BufWinEnter,WinEnter <buffer> startinsert!

     execute "tnoremap <buffer> <Esc> <C-\\><C-n><C-w><C-h>"
     execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q<CR>"
     execute "tnoremap <buffer> <C-7> <C-\\><C-\\><C-n>"
     startinsert!
   endif
endfunction

nmap <C-t> :call OpenTerminal()<CR>
