vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_command('autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab')
vim.api.nvim_command('autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab')
vim.api.nvim_command('autocmd FileType typescriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab')

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.clipboard = 'unnamed'

vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '88'

vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')

if vim.env.VIRTUAL_ENV then
  vim.g.python3_host_prog = vim.env.VIRTUAL_ENV .. '/bin/python'
end

