" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'dracula/vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" plugin to easy find file
Plug 'kien/ctrlp.vim'
" Markdown highlighter
Plug 'plasticboy/vim-markdown'
" Code tags
Plug 'majutsushi/tagbar'
map <Leader>t :CtrlPBuffer<CR>
 let g:ctrlp_map = '<C-p>'
 let g:ctrlp_working_path_mode = 0 " don’t manage working directory.
 let g:ctrlp_use_caching = 1
 let g:ctrlp_custom_ignore = {
 \ 'dir':  '\v\c\.(git|svn)$|cgi/t/sandbox|cover_db',
 \ 'file': '\v\c\.(swf|bak|png|gif|js|mov|ico|jpg|pdf|jrxml)$'
  \ }

" Initialize plugin system
call plug#end()
