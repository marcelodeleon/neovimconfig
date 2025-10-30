-- Enable true color
if vim.fn.exists('+termguicolors') == 1 then
    vim.opt.termguicolors = true
end

vim.cmd [[packadd! dracula_pro]]
vim.cmd [[syntax enable]]
vim.g.dracula_colorterm = 0
vim.cmd [[colorscheme dracula_pro]]


-- This is a Hack to add some colors to markdown when using treesitter and
-- dracula pro. The pro theme is missing the highlight groups for markdown...
-- I'm waiting for the team to let me know how to get the fixed version. I'll
-- keep this in the meantime.
local function set_markdown_highlights()
    -- Base colors from Dracula Theme
    vim.api.nvim_set_hl(0, 'Comment', {fg = '#6272a4', italic = true})
    vim.api.nvim_set_hl(0, 'Constant', {fg = '#ffb86c'})
    vim.api.nvim_set_hl(0, 'Identifier', {fg = '#50fa7b'})
    vim.api.nvim_set_hl(0, 'Statement', {fg = '#ff79c6', bold = true})
    vim.api.nvim_set_hl(0, 'PreProc', {fg = '#ff79c6'})
    vim.api.nvim_set_hl(0, 'Type', {fg = '#8be9fd'})
    vim.api.nvim_set_hl(0, 'Underlined', {fg = '#f1fa8c', underline = true})
    
    -- Markdown specific highlights
    vim.api.nvim_set_hl(0, '@markup.heading.1', {fg = '#ff79c6', bold = true})
    vim.api.nvim_set_hl(0, '@markup.heading.2', {fg = '#8be9fd', bold = true})
    vim.api.nvim_set_hl(0, '@markup.heading.3', {fg = '#50fa7b', bold = true})
    vim.api.nvim_set_hl(0, '@markup.heading.4', {fg = '#ffb86c', bold = true})
    vim.api.nvim_set_hl(0, '@markup.heading.5', {fg = '#bd93f9', bold = true})
    vim.api.nvim_set_hl(0, '@markup.list', {fg = '#f1fa8c'})
end

-- Automatically set custom highlights when entering a Markdown buffer
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = set_markdown_highlights
})

-- Fix diff highlighting for Fugitive and other diff views
-- The default Dracula Pro diff colors lack sufficient contrast, especially for additions.
-- This provides better visibility with background colors and proper contrast.
local function set_diff_highlights()
    -- Dracula Pro color palette
    local green = '#8AFF80'      -- Dracula Pro green
    local red = '#FF9580'        -- Dracula Pro red
    local orange = '#FFCA80'     -- Dracula Pro orange
    local yellow = '#FFFF80'     -- Dracula Pro yellow
    local bg = '#22212C'         -- Dracula Pro bg
    local bgdark = '#17161D'     -- Dracula Pro bgdark
    local bglighter = '#393649'  -- Dracula Pro bglighter

    -- Background colors with subtle alpha for better readability
    local green_bg = '#1a3320'   -- Dark green background for additions
    local red_bg = '#3a1a1a'     -- Dark red background for deletions
    local orange_bg = '#3a2a1a'  -- Dark orange background for changes

    -- DiffAdd: Lines that were added (green with dark green background)
    vim.api.nvim_set_hl(0, 'DiffAdd', {
        fg = green,
        bg = green_bg,
        bold = false
    })

    -- DiffDelete: Lines that were deleted (red with dark red background)
    vim.api.nvim_set_hl(0, 'DiffDelete', {
        fg = red,
        bg = red_bg,
        bold = false
    })

    -- DiffChange: Lines that were modified (orange with dark orange background)
    vim.api.nvim_set_hl(0, 'DiffChange', {
        fg = orange,
        bg = orange_bg,
        bold = false
    })

    -- DiffText: Specific parts of changed lines (yellow foreground, orange background, bold)
    vim.api.nvim_set_hl(0, 'DiffText', {
        fg = yellow,
        bg = orange_bg,
        bold = true
    })

    -- Git-specific diff highlights (used by some plugins)
    vim.api.nvim_set_hl(0, 'DiffAdded', {link = 'DiffAdd'})
    vim.api.nvim_set_hl(0, 'DiffRemoved', {link = 'DiffDelete'})

    -- Fugitive-specific highlights
    vim.api.nvim_set_hl(0, 'diffAdded', {link = 'DiffAdd'})
    vim.api.nvim_set_hl(0, 'diffRemoved', {link = 'DiffDelete'})
    vim.api.nvim_set_hl(0, 'diffChanged', {link = 'DiffChange'})
    vim.api.nvim_set_hl(0, 'diffLine', {fg = bglighter, italic = true})
    vim.api.nvim_set_hl(0, 'diffSubname', {fg = orange})
end

-- Apply diff highlights immediately after colorscheme loads
set_diff_highlights()

-- Reapply diff highlights when entering diff/git buffers to ensure they persist
vim.api.nvim_create_autocmd({"FileType", "BufEnter"}, {
    pattern = {"diff", "git", "fugitive", "fugitiveblame"},
    callback = set_diff_highlights
})
