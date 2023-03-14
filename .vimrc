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
set rnu
set mouse=a
set numberwidth=1
set clipboard=unnamed
set showcmd
set showmatch
set ruler
set encoding=utf-8
set sw=2
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
  Plug 'scrooloose/nerdtree'
  Plug 'shinchu/lightline-gruvbox.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf/', {'do': {->fzf#install()}}
  Plug 'preservim/nerdcommenter'
  "Plug 'christoomey/vim-tmux-navigator'

call plug#end()

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=1
highlight Normal ctermbg=NONE
colorscheme gruvbox
let mapleader = " "

nmap <C-s> :w<CR>
imap <C-s> <Esc> :w<CR>
nmap <C-q> :q!<CR>
imap <C-q> <Esc> :q!<CR>

imap <C-c> <Esc>
nmap > 5<C-w>>
nmap < 5<C-w><

nmap <C-a> :%y+<CR>
nmap <Leader>e :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeWinPos='right'

nmap <C-n> :bnext<CR>
nmap <C-w> :bdelete<CR>

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
   imap <F2> <Esc> :w<CR> :!java % && < inp<CR>
   nmap <F2> :w<CR> :!java % && < inp<CR>
endfunction

function! RunCpp()
   imap <F2> <Esc> :w<CR> :!g++ -std=c++20 -Wall -O2 -o "%<" "%" && "./%<" < inp<CR>
   nmap <F2> <Esc> :w<CR> :!g++ -std=c++20 -Wall -O2 -o %< % && ./%< < inp<CR>
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
   execute "normal \<C-l>"

   let bufNum = bufnr("%")
   let bufType = getbufvar(bufNum, "&buftype", "not found")

   if bufType == "terminal"
     " cerrar terminal existente
     execute "q"
   else
     " se abrirá la terminal cmd, pero si usted utiliza otra terminal, debes
     " poner el nombre del .exe o ejecutable ya sea: 'cmd, zsh, bash, iTerm', quedando la
     " línea (81) así: execute 'sp term://zsh'
     execute "sp term://bash"
     " apagar números
     execute "set nonu"
     execute "set nornu"

     " alternar insertar en entrar o salir
     silent au BufLeave <buffer> stopinsert!
     silent au BufWinEnter,WinEnter <buffer> startinsert!

     " establezco atajos dentro de la terminal
     execute "tnoremap <buffer> <Esc> <C-\\><C-n><C-w><C-h>"
     execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q<CR>"
     execute "tnoremap <buffer> <C-7> <C-\\><C-\\><C-n>"
     startinsert!
   endif
endfunction

nmap <C-t> :call OpenTerminal()<CR>
