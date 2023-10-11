"*-------------- Configuración Inicial [init.vim] 25/Septiembre/2022 11:29a.m COL --------------*

"                        ██╗███╗░░██╗██╗████████╗░░░██╗░░░██╗██╗███╗░░░███╗
"                        ██║████╗░██║██║╚══██╔══╝░░░██║░░░██║██║████╗░████║
"                        ██║██╔██╗██║██║░░░██║░░░░░░╚██╗░██╔╝██║██╔████╔██║
"                        ██║██║╚████║██║░░░██║░░░░░░░╚████╔╝░██║██║╚██╔╝██║
"                        ██║██║░╚███║██║░░░██║░░░██╗░░╚██╔╝░░██║██║░╚═╝░██║
"                        ╚═╝╚═╝░░╚══╝╚═╝░░░╚═╝░░░╚═╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
"                                      Creado por >> josuerom
"                             Twitter >> https://twitter.com/josueromr

syntax enable
set encoding=utf-8 
set number
set mouse=a
set numberwidth=1
set relativenumber
set clipboard=unnamedplus
set background=dark
set ruler
set sw=3
set tabstop=3
set expandtab
set smartindent
set termguicolors
set showmatch
set showcmd
set noshowmode
set laststatus=2
set hlsearch
set ignorecase
set smartcase
set splitbelow
set splitright
set hidden
set cmdheight=1
set updatetime=50
set shortmess+=c

call plug#begin('~/.config/nvim/plugged')

  Plug 'sheerun/vim-polyglot'
  Plug 'morhetz/gruvbox'
  Plug 'shinchu/lightline-gruvbox.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tpope/vim-surround'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'SirVer/ultisnips'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'preservim/nerdcommenter'
  Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
  Plug 'junegunn/fzf.vim'
  Plug 'jiangmiao/auto-pairs'

call plug#end()

let g:gruvbox_contrast_dark = "hard"
highlight Normal ctermbg = NONE
colorscheme gruvbox

" configuración de la barra de estado inferior
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
    \ }
    \}

let g:coc_global_extensions = ['coc-snippets', 'coc-java', 'coc-clangd']

" configuración de coc-snippets
let g:coc_snippets_next = '<c-j>'
let g:coc_snippets_prev = '<c-k>'
imap <C-l> <Plug>(coc-snippets-expand)
imap <C-j> <Plug>(coc-snippets-expand-jump)
xmap <Leader>y  <Plug>(coc-convert-snippet)

" cerrado automatico de la barra lateral o tree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos="right"

" navegación rápida tmux
let g:tmux_navigator_no_mappings=1

" interfaz de búsqueda FZF (Line Fuzzy Finder)
let $FZF_DEFAULT_OPTS='--layout=reverse'

"*---------------------- FUNCIÓN PARA INTEGRAR LA SHELL BASH O ZSH -------------------------*
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

"*---------------------- SOLUCIÓN A EL ERROR DE COC-SNIPPETS -----------------------*
" Si al iniciar neovim te aparece siempre este molestoso error:
" [coc.nvim] Error on execute :pyx command, ultisnips feature of coc-snippets requires pyx support on vim.
" ejecuta el sgt comando en tu distribución Linux:
" sudo dnf install python3 python3-pip -y && pip install pynvim

" Solución al error de (python3-script-host)
"let g:python3_host_prog="~/.virtualenvs/neovim-python3-venv/bin/python3"

let mapleader = " "

" refrescar las sugerencias para C++
autocmd FileType cpp setlocal omnifunc=coc#refresh()
" comando para autocargar mi template en archivos cpp y java
autocmd BufNewFile *.cpp 0r ~/workspace/templates/template.cpp
autocmd BufNewFile *.java 0r ~/workspace/templates/template.java

" comando para copiar en al portapapeles de Windows
if has('clipboard')
  set clipboard+=unnamedplus
endif
" suplanta al +y por C-c
vnoremap <C-c> "+y
" para copiar todo el archivo C-a
nnoremap <C-a> <Esc>ggVG<CR>

" FUNCIONES PARA COMPILACIONES
function! CompileCpp()
    let program_name = expand('%:r') . '.out'
    let compile_command = 'g++ -std=c++17 -Wall -Djosuerom -D_2BITS -pedantic ' . expand('%') . ' -o ~/workspace/bin/' . program_name
    " Compilar el programa
    let compile_output = systemlist(compile_command)
    " Verificar si hubo errores de compilación
    if v:shell_error
        echohl ErrorMsg
        echo 'Error de compilación:'
        for error_line in compile_output
            echo error_line
        endfor
        echohl None
    else
        echo 'Compilacion exitosa!'
    endif
endfunction

function! RunCpp()
    let program_name = expand('%:r')  . '.out'
    let run_command = '~/workspace/bin/' . program_name

    " Ejecutar el programa en una división vertical de la terminal
    leftabove vsplit term://./%:r
    "execute 'terminal ' . run_command . '< samples/in1'
    execute 'terminal time ' . run_command
    startinsert
endfunction

function! Compile&RunCpp()
    call CompileCpp()
    if !v:shell_error
        call RunCpp()
    endif
endfunction

function! Compile&RunJava()
    let program_name = expand('%:r')
    let run_command = 'java ' . program_name
    " Compilar el programa
    let compile_output = systemlist(run_command)
    " Verificar si hubo errores de compilación
    if v:shell_error
        echohl ErrorMsg
        echo 'Error de compilación:'
        for error_line in compile_output
            echo error_line
        endfor
        echohl None
    else
        echo 'Compilación exitosa!'
        " Ejecutar el programa en una división vertical de la terminal
        leftabove vsplit term://./%:r
        "execute 'terminal ' . run_command . '< samples/in1'
        execute 'terminal time ' . run_command
        startinsert
    endif
endfunction

" Atajos de teclado para llamar a los compiladores
autocmd FileType cpp nnoremap <silent><F1> :call CompileCpp()<CR>
autocmd FileType cpp nnoremap <silent><F2> :call RunCpp()<CR>
autocmd FileType cpp nnoremap <silent><F3> :call Compile&RunCpp()<CR>
autocmd FileType java nnoremap <silent><F3> :call Compile&RunJava()<CR>
autocmd BufWritePre * :%s/\s\+$//e

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

imap <C-c> <Esc>
imap ññ <Esc>

nnoremap <C-k> 50 <C-e>
nnoremap <C-j> 50 <C-y>

nnoremap > 5<C-w>>
nnoremap < 5<C-w><

nnoremap <Leader>, $a;<Esc>

nmap <Leader>t :call OpenTerminal()<CR> <Esc> :resize 14<CR>

nmap <Leader>¿ :e $MYVIMRC<CR>

nnoremap <F4> :w<CR> :e ~/workspace/sample/input<CR>
nnoremap <F5> :so $MYVIMRC<CR>
nnoremap <F6>kp :let @*=expand("%")<CR>
"nnoremap <F7> command_here<CR>

imap <C-c> <Esc> :w<CR> :%y+<CR>
nmap <C-c> :w<CR> :%y+<CR>

nmap <Leader>w :w<CR>
nmap <C-s> <Esc> :w<CR>
imap <C-s> <Esc> :w<CR>

nmap <C-q> :q<CR>
nmap <Leader>q :q<CR>
imap <C-q> <Esc> :q<CR>

nmap <C-x> :qa!<CR>
nmap <Leader>x :qa!<CR>
imap <C-x> <Esc> :qa!<CR>

nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>p :Explore<CR>
nmap <Leader>f :FZF<CR>

vmap }} <plug>NERDCommenterToggle
nmap }} <plug>NERDCommenterToggle
imap }} <Esc> :w<CR> <plug>NERDCommenterToggle

nnoremap <silent><C-h> :TmuxNavigateLeft<CR>
nnoremap <silent><C-j> :TmuxNavigateDown<CR>
noremap <silent><C-k> :TmuxNavigateUp<CR>
nnoremap <silent><C-l> :TmuxNavigateRight<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <Leader>ii :vsp<CR>

nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>h :bprevious<CR>
nnoremap <Leader>dl :bdelete<CR>

nmap <Leader>s <Plug>(easymotion-s2)

nnoremap <Leader>pi :PlugInstall<CR>
nnoremap <Leader>pc :PlugClean<CR>
nnoremap <Leader>pu :PlugUpdate<CR>
nnoremap <Leader>pp :PlugUpgrade<CR>

vnoremap < <gv
vnoremap > >gv

xmap s <Plug>VSurround

xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

nnoremap n :m .-2<CR>==
nnoremap m :m .+1<CR>==

nnoremap <silent><nowait> <F12> :<C-u>CocList snippets<CR>
nnoremap <silent><nowait> <Leader>cup :<C-u>CocUpdate<CR>
nnoremap <silent><nowait> <Leader>cun :<C-u>CocUninstall coc-

" dashboard.vim
" Limpia la pantalla
autocmd VimEnter * silent! colorscheme default | silent! filetype plugin indent off | silent! syntax off | silent! set noswapfile | silent! set nobackup | silent! set noundofile | silent! set nowrap
" Define la función para mostrar el dashboard
function! ViewWelcome()
    " Limpia el buffer actual y carga el archivo con el saludo
    silent! %bwipeout!
    silent! 0read ~/.config/nvim/welcome.txt
    set laststatus=0
endfunction

" Muestra el dashboard al iniciar Neovim
autocmd VimEnter * call ViewWelcome()
