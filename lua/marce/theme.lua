-- Enable true color
if vim.fn.exists('+termguicolors') == 1 then
    vim.opt.termguicolors = true
end

vim.cmd [[packadd! dracula_pro]]
vim.cmd [[syntax enable]]
vim.g.dracula_colorterm = 0
vim.cmd [[colorscheme dracula_pro]]
