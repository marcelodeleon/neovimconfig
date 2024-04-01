local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    },

    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    {"ellisonleao/gruvbox.nvim", config = function()
        -- Use the Gruvbox theme
        vim.cmd.colorscheme('gruvbox')
    end},

    -- Tpope Madness!
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb", -- Adds GitHub functionality to `vim-fugitive`.
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "tpope/vim-commentary",
    "tpope/vim-eunuch", -- UNIX helpers.
    "tpope/vim-repeat",

    -- Allows to navigate vim and tmux panes as if they were the same.
    "christoomey/vim-tmux-navigator",

    -- Telescope
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",

    -- Icons.
    "ryanoasis/vim-devicons",
    "kyazdani42/nvim-web-devicons",
    "onsails/lspkind.nvim",

    -- Insert/delete quotes, parens and the likes in pairs.
    "windwp/nvim-autopairs",

    -- Integrate external tools (like black, flake8, and isort),
    -- directly into Neovim's built-in LSP.
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' }
    },
}

require("lazy").setup(plugins, {})
