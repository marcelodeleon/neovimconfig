-- Split navigations
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")

-- Sources the current vimscript
vim.keymap.set("n", "<leader>so", ":source %<cr>", {silent=true})

-- Quick file mappings
vim.keymap.set("n", "<leader>s", ":update<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":q<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", ":Ex<CR>", { silent = true })

-- Spellchecking mappings
vim.keymap.set("n", "<leader>zz", "1z=")
vim.keymap.set("n", "<leader>zx", "z=")

-- Allow the . to execute once for each line of a visual selection
vim.keymap.set("v", ".", ":normal .<CR>", { silent = true })

-- Command history filter with <C-n> and <C-p>
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")

-- Expands path of the active buffer in commmand-line mode when typing '%%'
-- TODO: Fix, not working
vim.keymap.set("c", "<expr> %%", "getcmdtype() == ':' ? expand('%:h').'/' : '%%'")

-- Show invisible characters
vim.keymap.set("n", "<leader>h", ":set list!<CR>", { silent = true })

-- Open quickfix window
vim.keymap.set("n", "<leader>c", ":copen <CR>", { silent = true })

-- Open locallist window
vim.keymap.set("n", "<leader>l", ":lopen <CR>", { silent = true })
