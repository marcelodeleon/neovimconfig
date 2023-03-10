local fn = vim.fn

vim.g.package_home = fn.stdpath("data") .. "/site/pack/packer"
local packer_install_dir = vim.g.package_home .. "/opt/packer.nvim"

local plug_url_format = ""
if vim.g.is_linux then
  plug_url_format = "https://hub.fastgit.xyz/%s"
else
  plug_url_format = "https://github.com/%s"
end

local packer_repo = string.format(plug_url_format, "wbthomason/packer.nvim")
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

-- Auto-install packer in case it hasn't been installed.
if fn.glob(packer_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  vim.cmd(install_cmd)
end

-- Load packer.nvim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Plugins Install
require("packer").startup({
    function(use)
        -- Packer can manage itself
        use "wbthomason/packer.nvim"

        -- IDE like features.
        use {
            'VonHeikemen/lsp-zero.nvim',
            requires = {
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
        }

        use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

        -- Tpope Madness!
        use "tpope/vim-fugitive"
        use "tpope/vim-rhubarb" -- Adds GitHub functionality to `vim-fugitive`.
        use "tpope/vim-surround"
        use "tpope/vim-unimpaired"
        use "tpope/vim-commentary"
        use "tpope/vim-eunuch" -- UNIX helpers.
        use "tpope/vim-repeat"

        -- Allows to navigate vim and tmux panes as if they were the same.
        use "christoomey/vim-tmux-navigator"

        -- Telescope
        use "nvim-lua/popup.nvim"
        use "nvim-lua/plenary.nvim"
        use "nvim-telescope/telescope.nvim"
        use "nvim-telescope/telescope-fzy-native.nvim"

        -- Icons.
        use "ryanoasis/vim-devicons"
        use "kyazdani42/nvim-web-devicons"
        use "onsails/lspkind.nvim"

        -- Insert/delete quotes, parens and the likes in pairs.
        use "windwp/nvim-autopairs"

        use {
            "nvim-neorg/neorg",
            run = ":Neorg sync-parsers",
            config = function()
                require('neorg').setup {
                    load = {
                        ["core.defaults"] = {}, -- Loads default behaviour
                        ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                        ["core.norg.dirman"] = { -- Manages Neorg workspaces
                            config = {
                                workspaces = {
                                    notes = "~/notes",
                                },
                            },
                        },
                    },
                }
            end,
            requires = "nvim-lua/plenary.nvim",
        }
    end,
    config = {
        -- Use floating window for command outputs.
        display = {
            open_fn = require("packer.util").float,
        }
    }
})

-- PackerCompile must be run whenever the plugins config is updated.
-- This autocmd makes sure we always run PackerCompile after updates.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
