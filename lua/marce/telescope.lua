local themes = require('telescope.themes')
local M = {}

function M.git_files()
    local opts = themes.get_dropdown {
        windblend = 10,
        border = true,
        previewer = false,
        shorten_path = false,
    }

    require('telescope.builtin').git_files(opts)
end

function M.edit_neovim()
    require('telescope.builtin').git_files {
        shorten_path = true,
        cwd = "~/.neovim",
        prompt = "~ Neovim Configuration ~",
        height = 10,
        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        },
    }
end

return M
