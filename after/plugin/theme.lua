-- Enable true color
vim.cmd[[
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
]]

vim.cmd("packadd! dracula_pro")

vim.g.syntax = true
vim.g.dracula_colorterm = 0

vim.cmd("colorscheme dracula_pro")
