" be better by not being vi compatible; lots of things need this
set nocompatible

" vundle packages
filetype off " vundle likes this off during setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'        " this package manager
Plugin 'NLKNguyen/papercolor-theme'  " googley colors
Plugin 'vim-airline/vim-airline'     " fancy status bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'          " fast file/buffer finder
Plugin 'scrooloose/nerdtree'         " file navigator
Plugin 'scrooloose/nerdcommenter'    " commenting functions
Plugin 'Xuyuanp/nerdtree-git-plugin' " git for NERDTree
Plugin 'scrooloose/syntastic'        " syntax checking
Plugin 'google/vim-codefmt'          " code formatting
Plugin 'google/vim-maktaba'          " required by vim-codefmt
Plugin 'google/vim-glaive'           " required by vim-codefmt
Plugin 'tpope/vim-fugitive'          " git commands and statusline
Plugin 'fatih/vim-go'                " golang super plugin
Plugin 'leafgarland/typescript-vim'  " typescript syntax highlighting
Plugin 'moll/vim-bbye'               " delete buffer without closing window
Plugin 'Valloric/YouCompleteMe'      " code-completion
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
let g:airline_theme='dark'

" status
set laststatus=2       " always show status line
set number             " show line numbers in gutter
set colorcolumn=80,100 " show vertical lines at these columns
set cursorline         " make the current line more obvious
set scrolloff=5        " minimum lines to keep above/below cursor

" switch modes faster
set timeoutlen=1000
set ttimeoutlen=0

" when switching away from a buffer, make it "hidden" instead of unloading it,
" so that vim doesn't complain about abandoning buffers with unsaved changes
set hidden

" By default, backspace in insert mode will not remove autoindentation, line
" breaks, or anything before the position where indent mode was entered
" (although many distros override this default). Allow all of these instead.
set backspace=indent,eol,start

" indentation
set expandtab     " <tab> inserts spaces instead of a tab
set tabstop=2     " number of columns to draw for a tab character
set softtabstop=2 " number of spaces to insert when pressing <tab>
set shiftwidth=2  " number of spaces to insert when indenting
set autoindent    " use the previous line's indent when starting a new line
set textwidth=80  " wrap text at this column

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

" don't unselect text when indenting
vmap < <gv
vmap > >gv

" navigate location/quickfix lists more easily (e.g. syntastic errors, grep)
" taken from http://github.com/tpope/vim-unimpaired
nmap [l :lprev<CR>
nmap ]l :lnext<CR>
nmap [q :cprev<CR>
nmap ]q :cnext<CR>

" some common commands
nmap <leader>s :SyntasticCheck<CR>
nmap <leader>w :w<CR>
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>m :NERDTreeFind<CR>
nmap <leader>f :CtrlP<CR>
nmap <leader>r :CtrlPMRU<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>x :Bdelete!<CR>
nmap <leader>d :YcmCompleter GetDoc<CR>
nmap <leader>t :YcmCompleter GetType<CR>
nmap <leader>g :YcmCompleter GoToDefinition<CR>
nmap <leader>h :YcmCompleter GoToReferences<CR>
nmap <leader>i :set wrap!<CR>

" search for current visual selection
vmap // y/<C-R>"<CR>

" cd to directory of current file
nmap <leader>c :cd %:p:h<CR>

" search/replace word under cursor
nmap <leader>z :%s/\<<C-r><C-w>\>//g<left><left>

" fancy status bar glyphs (requires amended font)
let g:airline_powerline_fonts = 1

" use silver searcher for :grep
set grepprg=ag\ --nogroup\ --nocolor

" use silver searcher for listing files in ctrlp
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0 " it's so fast we don't need a file cache

" syntax checking
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1    " automatically open/close error window
let g:syntastic_aggregate_errors = 1 " combine errors from different checkers
let g:syntastic_check_on_open = 1    " check as soon as a file is opened
let g:syntastic_check_on_wq = 0      " skip checks when exiting

" some syntax checks are slow or are bad; don't run them automatically
let g:syntastic_mode_map = {'passive_filetypes': ['typescript', 'html']}

" automatically maintain go imports
let g:go_fmt_command = 'goimports'

" there are lots of tools for checking go code
let g:syntastic_go_checkers = ['go', 'gofmt', 'govet', 'golint']

" don't warn about typescript decorators
let g:syntastic_typescript_tsc_post_args='--experimentalDecorators'

" extended go highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" auto formatters
augroup codefmt_settings
  autocmd FileType javascript AutoFormatBuffer clang-format
  autocmd FileType typescript AutoFormatBuffer clang-format
augroup END

" NERDTree
let NERDTreeShowBookmarks = 1    " show bookmarks on startup
let NERDTreeShowHidden = 1       " show hidden files on startup
let NERDTreeMinimalUI = 1        " dont show help text
let NERDTreeAutoDeleteBuffer = 1 " always reload buffer when file moved
