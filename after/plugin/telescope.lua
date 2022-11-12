vim.keymap.set("n", "<C-P>", ":lua require('marce.telescope').git_files()<CR>")
vim.keymap.set("n", "<leader>n", ":lua require('marce.telescope').edit_neovim()<CR>")
vim.keymap.set("n", "<leader>ps", ":lua require('telescope.builtin').grep_string()<CR>")
vim.keymap.set("n", "<leader>f", ":lua require('telescope.builtin').find_files()<CR>")

vim.keymap.set("n", "<leader>pb", ":lua require('telescope.builtin').buffers()<CR>")
vim.keymap.set("n", "<leader>vh", ":lua require('telescope.builtin').help_tags()<CR>")

-- TODO: Fix
vim.keymap.set("n", "<C-F>", ":lua require('telescope.builtin').file_browser({ hidden: true })<CR>")
vim.keymap.set("n", "<leader>gb", ":lua require('marce.telescope').git_branches()<CR>")
vim.keymap.set("n", "<leader>gg", ":lua require('telescope.builtin').live_grep()<cr>")

-- " Moody's keymaps
vim.keymap.set("n", "<leader>j", ":lua require('marce.telescope').find_maa_ml_monorepo()<CR>")
vim.keymap.set("n", "<leader>gm", ":lua require('marce.telescope').live_grep_maa_ml_monorepo()<CR>")
