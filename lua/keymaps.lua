-- Split navigations
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")

-- Sources the current vimscript
vim.keymap.set("n", "<leader>so", ":source %<cr>")

-- Quick file mappings
vim.keymap.set("n", "<leader>s", ":update<CR>")
vim.keymap.set("n", "<leader>w", ":q<CR>")
vim.keymap.set("n", "<leader>e", ":Ex<CR>")
