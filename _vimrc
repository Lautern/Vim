"  статье хочетс€ добавить:
"Ч Syntastic Ч без этого плагина Python-разработчику жить трудно Ч в реальном времени находит и подсвечивает ошибки синтаксиса и PEP-8, а если установите jshint Ч то еще и Javascript
"Ч notes Ч удобно дл€ хранени€ заметок, особенно если поместить файлы заметок в систему контрол€ версий
"Ч ropevim Ч что там говорить, главный инструмент рефакторинга Ч переименовани€ глобальных имен в проекте, автоимпорт и т. д. Ч часть pymode, но € предпочитаю пользоватьс€ им отдельно от последнего; требует написани€ конфига проекта дл€ корректной работы с virtualenv Ч обращайтесь, могу дать пример
"Ч EnhancedCommentify Ч удобно дл€ быстрого комментировани€ кода на любом €зыке

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


"-------------------my stuff begins here-----------------------

set sessionoptions=buffers
"remember buffers
exec 'set viminfo=%,' . &viminfo  
set hidden
set nu
colorscheme strawimodo
set guifont=Consolas:h8:b
"set lines=45 columns=130
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
"autocmd vimenter * NERDTree
set noerrorbells
nnoremap ; :
au GUIEnter * simalt ~x 	"Maximize windows
set guifont=Consolas:h10:b
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>
:nnoremap <enter> i<enter><esc>
:nnoremap <space> i<space><esc>
set guioptions -=m
set guioptions -=T
set guioptions-=r " remove right-hand scroll bar
set guioptions-=L " remove left-hand scroll bar

set rnu
" Fix relativenumber, always show the current line number between the relative numbers, instead null.
au BufEnter * set nu
au BufEnter * set relativenumber

set enc=utf-8	     " utf-8 по дефолту в файлах
set ls=2             " всегда показываем статусбар
set incsearch	     " инкреминтируемый поиск
set hlsearch	     " подсветка результатов поиска
set nu	             " показывать номера строк
set scrolloff=5	     " 5 строк при скролле за раз

"  при переходе за границу в 80 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
augroup vimrc_autocmds
    autocmd!
    autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
    autocmd FileType ruby,python,javascript,c,cpp set nowrap
augroup END

" указываем каталог с настройками SnipMate
let g:snippets_dir = "C:/Users/nik/.vim/bundle/vim-snippets/snippets/"


let g:ctrlp_working_path_mode = 'ca' 

" TagBar настройки
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0 " автофокус на Tagbar при открытии

" NerdTree настройки
" показать NERDTree на F3
map <F3> :NERDTreeToggle<CR>
"игноррируемые файлы с расширени€ми
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']  

nnoremap <F2> zfit 	   

" –абота буфферами
map <C-q> :bd<CR> 	   " CTRL+Q - закрыть текущий буффер

" map :Unite to F8
map <F8> :Unite buffer<CR>

au! filetypedetect BufRead,BufNewFile *.txt    setfiletype txtfmt 
set ruler
set completeopt-=preview
set gcr=a:blinkon0
"if has("gui_running")
"  set cursorline
"endif
set ttyfast

tab sball
set switchbuf=useopen

" отключаем бэкапы и своп-файлы
set nobackup 	     " no backup files
set nowritebackup    " only in case you don't want a backup file while editing
set noswapfile 	     " no swap files
set tabstop=4

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"=====================================================
" User hotkeys
"=====================================================
" ConqueTerm
" запуск интерпретатора на F5
"nnoremap <F5> :ConqueTermSplit ipython<CR>
" а debug-mode на <F6>
"nnoremap <F6> :exe "ConqueTermSplit ipython " . expand("%")<CR>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 0
" проверка кода в соответствии с PEP8 через <leader>8
autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>

" автокомплит через <Ctrl+Space>
inoremap <C-space> <C-x><C-o>

" переключение между синтаксисами
nnoremap <leader>Th :set ft=htmljinja<CR>
nnoremap <leader>Tp :set ft=python<CR>
nnoremap <leader>Tj :set ft=javascript<CR>
nnoremap <leader>Tc :set ft=css<CR>
nnoremap <leader>Td :set ft=django<CR>
nnoremap <leader>Tm :set ft=matlab<CR>



"=====================================================
" Languages support
"=====================================================
" --- Python ---
"autocmd FileType python set completeopt-=preview " раскомментируйте, в случае, если не надо, чтобы jedi-vim показывал документацию по методу/классу
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" --- JavaScript ---
let javascript_enable_domhtmlcss=1
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.json setlocal ft=javascript

" --- HTML ---
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" --- template language support (SGML / XML too) ---
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd bufnewfile,bufread *.rhtml setlocal ft=eruby
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
"let html_no_rendering=1
"let g:closetag_default_xml=1
"let g:sparkupNextMapping='<c-l>'
"autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
"autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source c:/Users/nik/Dropbox/Vim/myVim/vimfiles/plugin/closetag.vim

" --- CSS ---
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4





"---------------PLUGIN INSTALL-----------------------------

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=C:/Users/nik/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('G:/myVim/vimfiles/bundle')

"----------------DEFINE YOUR PLUGINS HERE-----------------
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vitalk/vim-simple-todo'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-misc'
Plugin 'scrooloose/nerdtree' 	    	" Project and file navigation
"------------------=== Airline ===----------------------
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mattn/emmet-vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-fugitive'
" --- Python ---
Plugin 'klen/python-mode'	        " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
Plugin 'davidhalter/jedi-vim' 		" Jedi-vim autocomplete plugin
"Plugin 'junegunn/goyo.vim'
"Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim
Plugin 'tmhedberg/SimpylFold'	"use :help fold-commands for more info
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"--------------=== Snippets support ===---------------
Plugin 'garbas/vim-snipmate'		" Snippets manager
Plugin 'MarcWeber/vim-addon-mw-utils'	" dependencies #1
Plugin 'tomtom/tlib_vim'		" dependencies #2
Plugin 'honza/vim-snippets'		" snippets repo
Plugin 'easymotion/vim-easymotion' "Easymotion
Plugin 'haya14busa/incsearch.vim'
"Plugin 'kien/ctrlp.vim'		"use :help ctrlp-options for more info

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" настройки Vim-Airline
set laststatus=2
let g:airline_theme='kolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"=====================================================
" Python-mode settings
"=====================================================
" отключаем автокомплит по коду (у нас вместо него используетс€ jedi-vim)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" документаци€
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
" проверка кода
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="W391,W0612,E501,W601,C0110,E231"
" провека кода после сохранени€
let g:pymode_lint_write = 1

" поддержка virtualenv
let g:pymode_virtualenv = 1

" установка breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" подстветка синтаксиса
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" отключить autofold по коду
let g:pymode_folding = 0

" возможность запускать код
let g:pymode_run = 0






" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)




map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)



"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

