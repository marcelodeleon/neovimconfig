let mapleader = " "

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Sources the current vimscript
nnoremap <leader>so :source %<cr>

" Quick file mappings
noremap <leader>s :update<CR> 
noremap <leader>w :q<CR> 
noremap <leader>e :Ex<CR> 

" Spellchecking mappings
noremap <leader>zz 1z=
noremap <leader>zx z=

" Allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Automatically change dir when switching files.
" This enables :compl-filename to give me proper relative filenames.
set autochdir

" Command history filter with <C-n> and <C-p>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

"Remove all leading whitespace by pressing F4
nnoremap <F4> :%s/^ \+//<CR>

" Expands path of the active buffer in commmand-line mode when typing '%%'
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Show invisible characters
" Shortcut to rapidly toggle `set list`
nmap <leader>h :set list!<CR>

" Open quickfix window
nmap <leader>c :copen<CR>

" Open locallist window
nmap <leader>l :lopen<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Use 2 spaces for indentation for Javascript
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2


language en_US

" Auto-install vim-plug
let vim_plug_path = $HOME . '/.local/share/nvim/site/autoload/plug.vim'
if empty(glob(vim_plug_path))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Theme related plugins
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'


" Tpope Madness!
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'

" IDE like features
" Commenting out lspconfig and completion-nvim since these are causing issues
" with vim fugitive at the moment!
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'maxmellon/vim-jsx-pretty'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Insert/delete quotes, parens and the likes in pairs
Plug 'jiangmiao/auto-pairs'

" Vim Wiki
Plug 'vimwiki/vimwiki'

" Allows to navigate vim and tmux panes as if they were the same.
Plug 'christoomey/vim-tmux-navigator'

" Calendar for vim, it integrates with vimwiki.
Plug 'git://github.com/mattn/calendar-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
" Plug 'metakirby5/codi.vim'
" Plug 'mattn/emmet-vim'
" Plug 'dbeniamine/cheat.sh-vim'

" Python specific plugins.
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-repeat'
call plug#end()

"Configure dracula-pro theme
"Remember to install by hand the theme files
packadd! dracula_pro
syntax enable
let g:dracula_colorterm = 0
colorscheme dracula_pro

" Need to manually define the python3 binary that Neovim uses to
" avoid problem when running Neovim from virtual envs.
let g:python3_host_prog = '/usr/local/bin/python3'

lua require("marce")
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
