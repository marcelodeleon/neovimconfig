local actions = require('telescope.actions')
local themes = require('telescope.themes')

require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' >',

        layout_config = {
            prompt_position = 'top',
        },

        color_devicons = true,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}

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

function M.find_maa_ml_monorepo()
    local opts = themes.get_dropdown {
        windblend = 10,
        border = true,
        previewer = false,
        shorten_path = false,
        hidden = true,
        cwd = "~/work/moodys/projects/maa-ml-esg-monorepo",
    }

    require('telescope.builtin').find_files(opts)
end

function M.live_grep_maa_ml_monorepo()
    require('telescope.builtin').live_grep {
        cwd = "~/work/moodys/projects/maa-ml-esg-monorepo",
        prompt_title = "~ Search MAA-ML Monorepo ~",
        path_display = { "shorten" },
    }
end

function M.edit_neovim()
    require('telescope.builtin').git_files {
        shorten_path = true,
        cwd = "~/.neovim",
        prompt_title = "~ Neovim Configuration ~",
        height = 10,
        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        },
    }
end

function M.git_branches()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end
    })
end

return M
