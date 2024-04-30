local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.prettier.with({
        extra_args = { "--single-quote", "--jsx-single-quote" },
        -- Adjust `extra_args` based on your Prettier config preferences
    }),
    null_ls.builtins.diagnostics.eslint.with({
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    }),
    null_ls.builtins.code_actions.eslint.with({
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    }),
  },
})

vim.api.nvim_set_keymap('n', '<leader>p', ':%!prettier --stdin-filepath %<CR>', { noremap = true, silent = true })
