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
