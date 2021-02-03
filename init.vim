set exrc
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set colorcolumn=80

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Sources the current vimscript
nnoremap <leader>sop :source %<cr>

" Quick file mappings
noremap <leader>s :update<CR> 
noremap <leader>w :q<CR> 

" Command history filter with <C-n> and <C-p>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Expands path of the active buffer in commmand-line mode when typing '%%'
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Show invisible characters
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

language en_US

let mapleader = " "
