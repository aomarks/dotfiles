" be better by not being vi compatible; lots of things need this
set nocompatible

" vundle packages
filetype off " vundle likes this off during setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'       " this package manager
Plugin 'NLKNguyen/papercolor-theme' " googley colors
Plugin 'vim-airline/vim-airline'    " fancy status bar
Plugin 'ctrlpvim/ctrlp.vim'         " fast file/buffer finder
Plugin 'scrooloose/nerdtree'        " file navigator
Plugin 'scrooloose/syntastic'       " syntax checking
Plugin 'tpope/vim-fugitive'         " git commands and statusline
Plugin 'fatih/vim-go'               " golang super plugin
Plugin 'leafgarland/typescript-vim' " typescript syntax highlighting
call vundle#end()

" detect file types and load the corresponding plugin/indentation file
filetype plugin indent on

" put swap files here instead of in each file's own directory
" '//' uses file's absolute path for the swap file name
set directory=~/.vim/swap//

" colors
set background=dark
color PaperColor
syntax enable

" status
set laststatus=2       " always show status line
set number             " show line numbers in gutter
set colorcolumn=80,100 " show vertical lines at these columns

" indentation
set expandtab     " <tab> inserts spaces instead of a tab
set tabstop=2     " number of columns to draw for a tab character
set softtabstop=2 " number of spaces to insert when pressing <tab>
set shiftwidth=2  " number of spaces to insert when indenting
set autoindent    " use the previous line's indent when starting a new line

" search
set ignorecase " case insensitive by default
set smartcase  " case sensitive if there's a capital
set incsearch  " show matches as you type
set hlsearch   " highlight all search matches
set nowrapscan " don't wrap searches around the end of the file

" mouse in all modes
set mouse=a

" enhanced command-line completion
" list matches and complete longest common string, then cycle through matches
set wildmenu
set wildmode=list:longest,full

" move up and down by visual line when wrapped, instead of by file line
nmap j gj
nmap k gk

" navigate location list (e.g. syntastic errors)
nmap [l :lprev<CR>
nmap ]l :lnext<CR>

" toggle NERDTree more easily
map <C-n> :NERDTreeToggle<CR>

" fancy status bar glyphs (requires amended font)
let g:airline_powerline_fonts = 1

" start ctrlp with most recently used files
let g:ctrlp_cmd = 'CtrlPMRU'

" syntax checking
let g:syntastic_auto_loc_list = 1    " automatically open/close error window
let g:syntastic_aggregate_errors = 1 " combine errors from different checkers
let g:syntastic_check_on_open = 1    " check as soon as a file is opened
let g:syntastic_check_on_wq = 0      " skip checks when exiting

" automatically maintain go imports
let g:go_fmt_command = "goimports"

" there are lots of tools for checking go code
let g:syntastic_go_checkers = ['go', 'gofmt', 'govet', 'golint']

" extended go highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
