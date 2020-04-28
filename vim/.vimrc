" be better by not being vi compatible; lots of things need this
set nocompatible

" enable syntax highlighting
syntax on

" show line numbers in the gutter
set number

" make gutter line numbers grey instead of yellow
highlight LineNr ctermfg=grey

" highlight the current line
"set cursorline
 
" show a vertical line at this column
set colorcolumn=80

" make the vertical line blue instead of red
highlight ColorColumn ctermbg=4

" show matches as you type
set incsearch

" highlight all search matches
set hlsearch

" don't wrap searches around the end of the file
set nowrapscan

" case insensitive search by default, unless there's a capital
set ignorecase smartcase

" \s to start search/replace for word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/

" \w to write
if exists('g:vscode')
  nnoremap <leader>w <Cmd>call VSCodeCall('workbench.action.files.save')<CR>
else
  nmap <leader>w :w<CR>
endif

" \p to toggle wrap
if exists('g:vscode')
  nnoremap <leader>p <Cmd>call VSCodeCall('editor.action.toggleWordWrap')<CR>
else
  nmap <leader>p :set wrap!<CR>
endif

" always keep this many lines above/below cursor
set scrolloff=5

" switch terminal cursor based on mode
let &t_SI = "\<Esc>[6 q" " insert  = bar
let &t_SR = "\<Esc>[4 q" " replace = underline
let &t_EI = "\<Esc>[2 q" " normal  = block

" put swap files here instead of in each file's own directory
" '//' uses file's absolute path for the swap file name
set directory=~/.vim/swap//

" move up and down by visual line when wrapped, instead of by file line
nmap j gj
nmap k gk

" indentation
set expandtab     " <tab> inserts spaces instead of a tab
set tabstop=2     " number of columns to draw for a tab character
set softtabstop=2 " number of spaces to insert when pressing <tab>
set shiftwidth=2  " number of spaces to insert when indenting
set autoindent    " use the previous line's indent when starting a new line
set textwidth=80  " wrap text at this column
set nojoinspaces  " don't put two spaces after a [.?!] when joining lines

" list buffers and prompt for the buffer to open
nnoremap <leader>b :ls<CR>:b<Space>

" use ripgrep as grep command if available
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
endif

" \, -> edit vim config
map <leader>, :e $MYVIMRC<CR>

" \, -> save and load a vim script
nmap <leader>. :w<CR>:so %<CR>

" automatically reload vim config after saving it
autocmd! bufwritepost $MYVIMRC source $MYVIMRC