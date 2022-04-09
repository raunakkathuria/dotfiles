source ~/.config/nvim/plugins.vim

filetype plugin on

set nocompatible                                   " disable compatibility to old-time vi
set showmatch                                      " show matching
set ignorecase                                     " case insensitive
set mouse=v                                        " middle-click paste with
set hlsearch                                       " highlight search
set incsearch                                      " incremental search
set tabstop=4                                      " number of columns occupied by a tab
set softtabstop=4                                  " see multiple spaces as tabstops so <BS> does the right thing
set expandtab                                      " converts tabs to white space
set shiftwidth=4                                   " width for autoindents
set autoindent                                     " indent a new line the same amount as the line just typed
set number                                         " add line numbers
set wildmode=longest,list                          " get bash-like tab completions
filetype plugin indent on                          " allow auto-indenting depending on file type
syntax on                                          " syntax highlighting
set mouse=c                                        " disable mouse click
set clipboard=unnamedplus                          " using system clipboard
set cursorline                                     " highlight current cursorline
set cursorcolumn                                   " highlight current cursorcolumn
set cc=80                                          " set an 80 column border for good coding style
set ttyfast                                        " Speed up scrolling in Vim
set hidden                                         " swtich file without saving
set list                                           " Display unprintable characters f12 - switches
set nowrap                                         " do not automatically wrap on load
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping

" color schemes
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula

" open new split panes to right and below
set splitright
set splitbelow

" move line or visually selected block - alt+j/k
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv" move split panes to left/bottom/top/right
nnoremap <A-h> <C-W>H
nnoremap <A-j> <C-W>J
nnoremap <A-k> <C-W>K
nnoremap <A-l> <C-W>L" move between panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Press i to enter insert mode, and ii to exit insert mode.
:inoremap ii <Esc>
:inoremap jk <Esc>
:inoremap kj <Esc>
:vnoremap jk <Esc>
:vnoremap kj <Esc>

" open file in a text by placing text and gf
nnoremap gf :vert winc f<cr>" copies filepath to clipboard by pressing yf
:nnoremap <silent> yf :let @+=expand('%:p')<CR>
" copies pwd to clipboard: command yd
:nnoremap <silent> yd :let @+=expand('%:p:h')<CR>" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set tags=tags;/

" airline
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline_section_z = airline#section#create(['%p%%', 'linenr', '/%L', ' %v'])

map <F5> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
