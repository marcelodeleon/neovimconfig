-- Deletes any Fugitive buffer after exiting
vim.cmd([[
    autocmd BufReadPost fugitive://* set bufhidden=delete
]])

vim.keymap.set("n", "<leader>gs", ":G<CR>")
vim.keymap.set("n", "<leader>g0", ":0Gclog<CR>")
vim.keymap.set("n", "<leader>g-", ":Gclog<CR>")
