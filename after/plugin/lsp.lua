local lsp = require("lsp-zero")

lsp.preset("recommended")

-- Detect Poetry virtualenv dynamically
local function get_poetry_venv()
  -- Run 'poetry env info --path' in the current working directory
  local handle = io.popen("cd " .. vim.fn.getcwd() .. " && poetry env info --path 2>/dev/null")
  if handle then
    local venv_path = handle:read("*a")
    handle:close()
    venv_path = venv_path:gsub("%s+", "") -- trim whitespace
    if venv_path ~= "" then
      return venv_path
    end
  end
  return nil
end

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'pyright' },
  -- Automatically set up servers that are installed
  automatic_setup = true,
})
    
require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- Dedicated handler for Pyright with Poetry venv detection
    ["pyright"] = function ()
        require("lspconfig").pyright.setup({
            before_init = function(_, config)
                local venv_path = get_poetry_venv()
                if venv_path then
                    config.settings.python.pythonPath = venv_path .. "/bin/python"
                end
            end,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "workspace",
                    }
                }
            }
        })
    end,
}

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = require('lsp-zero').cmp_action()
local cmp_mappings = {
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
}

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

cmp.setup({
    mapping = cmp.mapping.preset.insert(cmp_mappings)
})

lsp.set_sign_icons({
    error = '',
    warn = '',
    hint = '',
    info = ''
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
