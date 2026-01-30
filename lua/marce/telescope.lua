local actions = require('telescope.actions')
local themes = require('telescope.themes')

local telescope = require('telescope')

telescope.setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' >',

        -- Dynamic path display: full path when it fits, shortened when too long
        path_display = function(_, path)
            -- Dropdown picker width is ~70 chars usable space (after icons/borders)
            local max_len = 70

            -- If path fits, show it fully
            if #path <= max_len then
                return path
            end

            -- Shorten directories but keep filename and parent dir full
            local parts = vim.split(path, "/")
            local shortened = {}
            for i, part in ipairs(parts) do
                if i >= #parts - 1 then
                    -- Keep last 2 parts (parent + filename) full
                    table.insert(shortened, part)
                else
                    table.insert(shortened, part:sub(1, 1))
                end
            end
            return table.concat(shortened, "/")
        end,

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
vim.keymap.set("n", "<C-P>", function()
  require('marce.telescope').git_files()
end, { silent = true })

local M = {}

function M.git_files()
    local opts = themes.get_dropdown {
        windblend = 10,
        border = true,
        previewer = false,
        -- Will use the global path_display = "smart" setting
    }

    require('telescope.builtin').git_files(opts)
end

function M.find_maa_ml_monorepo()
    local opts = themes.get_dropdown {
        windblend = 10,
        border = true,
        previewer = false,
        hidden = true,
        cwd = "~/work/moodys/projects/maa-ml-esg-monorepo",
        -- Will use the global path_display = "smart" setting
    }

    require('telescope.builtin').find_files(opts)
end

function M.live_grep_maa_ml_monorepo()
    require('telescope.builtin').live_grep {
        cwd = "~/work/moodys/projects/maa-ml-esg-monorepo",
        prompt_title = "~ Search MAA-ML Monorepo ~",
        -- Use truncate for live grep since you see more context in the preview
        path_display = { "truncate" },
    }
end

function M.edit_neovim()
    require('telescope.builtin').git_files {
        cwd = "~/.neovim",
        prompt_title = "~ Neovim Configuration ~",
        height = 10,
        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        },
        -- Will use the global path_display = "smart" setting
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
