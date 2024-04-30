vim.keymap.set("n", "<leader>n", ":lua require('marce.telescope').edit_neovim()<CR>", { silent = true })
vim.keymap.set("n", "<leader>ps", ":lua require('telescope.builtin').grep_string()<CR>", { silent = true })
vim.keymap.set("n", "<leader>f", ":lua require('telescope.builtin').find_files()<CR>", { silent = true })

vim.keymap.set("n", "<leader>pb", ":lua require('telescope.builtin').buffers()<CR>", { silent = true })
vim.keymap.set("n", "<leader>vh", ":lua require('telescope.builtin').help_tags()<CR>", { silent = true })

-- TODO: Fix
vim.keymap.set("n", "<C-F>", ":lua require('telescope.builtin').file_browser({ hidden: true })<CR>", { silent = true })
vim.keymap.set("n", "<leader>gb", ":lua require('marce.telescope').git_branches()<CR>", { silent = true })
vim.keymap.set("n", "<leader>gg", ":lua require('telescope.builtin').live_grep()<CR>", { silent = true })
