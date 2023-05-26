"*-------------------- Configuración Inicial [init.vim] 25/Mayo/2021 11:29a.m COL -----------------------*

"                   ██╗███╗░░██╗██╗████████╗░░░██╗░░░██╗██╗███╗░░░███╗
"                   ██║████╗░██║██║╚══██╔══╝░░░██║░░░██║██║████╗░████║
"                   ██║██╔██╗██║██║░░░██║░░░░░░╚██╗░██╔╝██║██╔████╔██║
"                   ██║██║╚████║██║░░░██║░░░░░░░╚████╔╝░██║██║╚██╔╝██║
"                   ██║██║░╚███║██║░░░██║░░░██╗░░╚██╔╝░░██║██║░╚═╝░██║
"                   ╚═╝╚═╝░░╚══╝╚═╝░░░╚═╝░░░╚═╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
"                                                   Creador >> josuerom
"                                                   Twitter >> https://twitter.com/josueromr

syntax enable
set number
set mouse=a
set numberwidth=1
set relativenumber
set clipboard=unnamedplus
set background=dark
set ruler
set sw=3
set tabstop=3
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

" integro intrucciones para eliminar espacios vacio y ejecutar archivos
autocmd BufWritePre * :%s/\s\+$//e
autocmd FileType java :call RunJava()
autocmd FileType cpp :call RunCpp()
autocmd FileType python :call RunPython()
autocmd FileType javascript :call RunJsAndTs()
autocmd FileType typescript :call RunJsAndTs()

"██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗  ██╗   ██╗██╗███╗   ███╗
"██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗  ██║██╔════╝  ██║   ██║██║████╗ ████║
"██████╔╝██║     ██║   ██║██║  ███╗██║██╔██╗ ██║███████╗  ██║   ██║██║██╔████╔██║
"██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║╚════██║  ╚██╗ ██╔╝██║██║╚██╔╝██║
"██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║███████║██╗╚████╔╝ ██║██║ ╚═╝ ██║
"╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝

call plug#begin('~/.config/nvim/plugins')

" resaltado de sintaxis
Plug 'sheerun/vim-polyglot'

" tema
Plug 'morhetz/gruvbox'

" barra de estado
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'itchyny/lightline.vim'

" barra lateral - iconos
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" búsqueda - agrupador
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'

" navegación entre pestañas
Plug 'christoomey/vim-tmux-navigator'

" autocompletado - snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'

" IDE
Plug 'terryma/vim-multiple-cursors'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'yggdroot/indentline'

call plug#end()

" ajuste del tema
let g:gruvbox_contrast_dark = "hard"
highlight Normal ctermbg = NONE
colorscheme gruvbox

"██████╗ ██╗     ██╗   ██╗ ██████╗        ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗   ██╗   ██╗██╗███╗   ███╗
"██╔══██╗██║     ██║   ██║██╔════╝       ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝   ██║   ██║██║████╗ ████║
"██████╔╝██║     ██║   ██║██║  ███╗█████╗██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗  ██║   ██║██║██╔████╔██║
"██╔═══╝ ██║     ██║   ██║██║   ██║╚════╝██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║  ╚██╗ ██╔╝██║██║╚██╔╝██║
"██║     ███████╗╚██████╔╝╚██████╔╝      ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝██╗╚████╔╝ ██║██║ ╚═╝ ██║
"╚═╝     ╚══════╝ ╚═════╝  ╚═════╝        ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ ╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝

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

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \]

" configuración de UltiSnips
"let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/snippets/ultisnips']
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<C-j>"
"let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" configuración de coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
let g:coc_snippets_next = '<c-j>'
let g:coc_snippets_prev = '<c-k>'
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
    " cerrar terminal existente
    execute "q"
  else
    " se abrirá la shell zsh, pero si usted utilizas otra, debes poner el nombre
    " de la shell en la línea 194, ya sea: 'zsh, bash, fish', quedando la así:
    " execute 'sp term://zsh'
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

"*---------------------- SOLUCIÓN A EL ERROR DE COC-SNIPPETS -----------------------*
" Si al iniciar neovim te aparece siempre este molestoso error:
" [coc.nvim] Error on execute :pyx command, ultisnips feature of coc-snippets requires pyx support on vim.
" ejecuta el sgt comando en tu distribución Linux:
" sudo dnf install python3 python3-pip -y && pip install pynvim

" Solución al error de (python3-script-host)
"let g:python3_host_prog="~/.virtualenvs/neovim-python3-venv/bin/python3"

"███████╗██╗  ██╗ ██████╗ ██████╗ ████████╗ ██████╗██╗   ██╗████████╗███████╗  ██╗   ██╗██╗███╗   ███╗
"██╔════╝██║  ██║██╔═══██╗██╔══██╗╚══██╔══╝██╔════╝██║   ██║╚══██╔══╝██╔════╝  ██║   ██║██║████╗ ████║
"███████╗███████║██║   ██║██████╔╝   ██║   ██║     ██║   ██║   ██║   ███████╗  ██║   ██║██║██╔████╔██║
"╚════██║██╔══██║██║   ██║██╔══██╗   ██║   ██║     ██║   ██║   ██║   ╚════██║  ╚██╗ ██╔╝██║██║╚██╔╝██║
"███████║██║  ██║╚██████╔╝██║  ██║   ██║   ╚██████╗╚██████╔╝   ██║   ███████║██╗╚████╔╝ ██║██║ ╚═╝ ██║
"╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝

let mapleader = " "

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

" para el modo NORMAL desabilito el desplazamiento con las flechas
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" salir del modo INSERT con <Esc> <Ctrl+c> o <jj>
imap <C-c> <Esc>
imap ññ <Esc>

" desplazamiento vertical rápido con (hacia abajo -> ctrl+e) (hacia arriba -> ctrl+y)
nnoremap <C-k> 50 <C-e>
nnoremap <C-j> 50 <C-y>

" cambia el tamaño de pestañas verticales
nnoremap > 5<C-w>>
nnoremap < 5<C-w><

" coloca un punto y coma al final de la línea, con <space+,>
nnoremap <Leader>, $a;<Esc>

" con <space+t> abres la terminal dentro neovim
nmap <Leader>t :call OpenTerminal()<CR> <Esc> :resize 14<CR>

" acceso rápido a archivos de configuración global
nmap <Leader>¿ :e $MYVIMRC<CR>

" abre el archivo de ES input
nnoremap <F4> :w<CR> :e ~/workspace/sample/input<CR>
" copia la ruta general del archivo abierto con <F4>
nnoremap <F5>kp :let @*=expand("%")<CR>
" abre el archivo de configuración general con <F3>
nnoremap <F6> :e $MYVIMRC<CR>
" refresca neovim con <F5>
nmap <F7> :so ~/.config/nvim/init.vim<CR>
" elimina todos los espacios en blanco que contenga el archivo, con <F2>
nnoremap <F8> :%s/\s\+$//e<CR>

" copia todo el contenido del archivo abierto con Ctrl + a
imap <C-a> <Esc> :w<CR> :%y+<CR>
nmap <C-a> :w<CR> :%y+<CR>

" para guardar los cambios del archivo presione <space+w> en modeo INSERT o NORMAL
nmap <Leader>w :w<CR>
nmap <C-s> <Esc> :w<CR>
imap <C-s> <Esc> :w<CR>
" para cerrar búfers <space+q>
nmap <C-q> :q<CR>
nmap <Leader>q :q<CR>
imap <C-q> <Esc> :q<CR>
" para salir rápidamente de nvim <space+x>
nmap <C-x> :qa!<CR>
nmap <Leader>x :qa!<CR>
imap <C-x> <Esc> :qa!<CR>

" abre el árbol, side bar o NERDTree
nmap <Leader>e :NERDTreeToggle<CR>
" abre arbol de nvim
nmap <Leader>p :Explore<CR>
" ejecute FZF (Fuzy Find Files)
nmap <Leader>f :FZF<CR>

" comentar por línea con <}+}>
vmap }} <plug>NERDCommenterToggle
nmap }} <plug>NERDCommenterToggle
imap }} <Esc> :w<CR> <plug>NERDCommenterToggle

" navegación rápida entre buffers abiertos
nnoremap <silent><C-h> :TmuxNavigateLeft<CR>
nnoremap <silent><C-j> :TmuxNavigateDown<CR>
noremap <silent><C-k> :TmuxNavigateUp<CR>
nnoremap <silent><C-l> :TmuxNavigateRight<CR>

" atajos para el flujo rápido con Git
nnoremap <Leader>go :GV<CR>
nnoremap <Leader>g :Git init<CR>
nnoremap <Leader>gs :Git status<CR>
nnoremap <Leader>ga :Git add -A<CR>
nnoremap <Leader>gc :Git commit -m "♻ Update"<CR>
nnoremap <Leader>gcc :Git commit -v<CR>
nnoremap <Leader>glo :Git log --oneline<CR>
nnoremap <Leader>grr :Git remote add origin https://github.com/$USER$/.git
nnoremap <Leader>gpp :Git push -u origin main<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gpu :Git push --set-upstream origin main<CR>
nnoremap <Leader>gf :Git fetch<CR>
nnoremap <Leader>gl :Git pull<CR>
nnoremap <Leader>gm :Git merge<CR>

" flujo instantaneo con COC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" dividir pantalla en dos [vertical] con <space+ii>
nnoremap <Leader>ii :vsp<CR>

" navegación entre pestañas abiertas con <spacer+l> y <space+h>
nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>h :bprevious<CR>
nnoremap <Leader>dl :bdelete<CR>

" búsqueda por dos carácteres con easymotion
nmap <Leader>s <Plug>(easymotion-s2)

" atajos para el gestor Vim-Plug
nnoremap <Leader>pi :PlugInstall<CR>
nnoremap <Leader>pc :PlugClean<CR>
nnoremap <Leader>pu :PlugUpdate<CR>
nnoremap <Leader>pp :PlugUpgrade<CR>

" indentar líneas y bloques en modo NORMAL o VISUAL
vnoremap < <gv
vnoremap > >gv

" para multiples cursores debe poner el cursor encima de una palabra y presionar
" <ctrl+n> para buscar las coincidencias en el archivo y luego presione <c>
" para editar el contenido seleccionado

" para agrupar una cadena de texto con cualquier simbolo ya sea: () [] {} '' ""
" debes selecionar la palabra hasta un carácter antes y presionar: <s+el-simbolo-a-usar>
" por ejemplo: <s+[>
xmap s <Plug>VSurround

" mover bloques de código seleccionado en modo VISUAL, V-LINE o V-BLOCK con <K> subes el código y con <J> lo bajas
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" cambia la posición de una línea
nnoremap n :m .-2<CR>==
nnoremap m :m .+1<CR>==

" Para camiar el carácter que contenga una cadena de texto o cambiar el carácteres que los contiene,
" por ejemplo: si tienes un: 'Hi! World' al presionar <cs+el-simbolo-a-usar> la cadena de carácteres
" que los agrupa magicamente se cambiaran sin necesidad de realizarlo manualmente

" administrar todos los snippets con <F12>
nnoremap <silent><nowait> <F12> :<C-u>CocList snippets<CR>
" actualizar extensiones
nnoremap <silent><nowait> <Leader>cup :<C-u>CocUpdate<CR>
" desintalar extensiones
nnoremap <silent><nowait> <Leader>cun :<C-u>CocUninstall coc-