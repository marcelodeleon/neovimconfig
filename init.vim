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

" Remove all trailing whitespace by pressing F5
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

" Auto-install vim-plug
let vim_plug_path = $HOME . '/.local/share/nvim/site/autoload/plug.vim'
if empty(glob(vim_plug_path))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'neovim/nvim-lspconfig'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Deals with surroundings
Plug 'tpope/vim-surround'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Insert/delete quotes, parens and the likes in pairs
Plug 'jiangmiao/auto-pairs'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Vim Wiki
Plug 'vimwiki/vimwiki'

" Sugar for UNIX commands.
" Specifically useful to rename open files in place.
Plug 'tpope/vim-eunuch'

" Allows to navigate vim and tmux panes as if they were the same.
Plug 'christoomey/vim-tmux-navigator'

" Calendar for vim, it integrates with vimwiki.
Plug 'git://github.com/mattn/calendar-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

colorscheme dracula
