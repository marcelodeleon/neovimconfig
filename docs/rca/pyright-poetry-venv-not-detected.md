# RCA: Pyright Cannot Resolve Imports in Poetry Projects

**Date:** 2025-12-09
**Status:** Resolved
**Impact:** Python LSP import resolution, go-to-definition broken for library packages

## Issue Summary

In neovim, Pyright LSP could not resolve imports from Poetry-installed packages, causing:
- Lint errors on valid imports (e.g., `from galileo.lib.crypto import encrypt`)
- Go-to-definition (gd) not working on imported symbols
- Missing autocomplete for library functions
- Type hints from libraries not recognized

## Root Cause Analysis

### The Problem

**Pyright was searching the wrong Python environment.**

**Expected behavior:**
- Pyright should search: `/Users/marcelodeleon/Library/Caches/pypoetry/virtualenvs/payment-hub-workflows-Pe1N7Nwj-py3.12/lib/python3.12/site-packages`

**Actual behavior:**
- Pyright searched: `/Users/marcelodeleon/.pyenv/versions/3.12.3/lib/python3.12/site-packages` (base Python)

### Why This Happened

1. **Poetry's virtualenv location**: Poetry creates virtualenvs in a cache directory by default (`~/.cache/pypoetry/virtualenvs` or `~/Library/Caches/pypoetry/virtualenvs` on macOS)

2. **Non-standard naming**: Poetry virtualenvs include a hash in the name (e.g., `payment-hub-workflows-Pe1N7Nwj-py3.12`), making them unpredictable

3. **Pyright's detection logic**: Pyright looks for virtualenvs in standard locations:
   - `.venv/` in project root
   - `venv/` in project root
   - System Python paths
   - Does NOT automatically detect Poetry's cache directory

4. **Default LSP configuration**: The neovim LSP config used default handlers without specifying a Python environment

### Investigation Details

**LSP Server:** Pyright 1.1.367 (installed via Mason)

**Configuration:** Using lsp-zero with default handlers

**Poetry Setup:**
```bash
$ poetry env info --path
/Users/marcelodeleon/Library/Caches/pypoetry/virtualenvs/payment-hub-workflows-Pe1N7Nwj-py3.12
```

**Pyright Search Paths (from LSP log):**
- System Python: `/Users/marcelodeleon/.pyenv/versions/3.12.3/lib/python3.12/site-packages`
- Missing: Poetry virtualenv packages

## Solution Evaluation

### Option 1: Create `pyrightconfig.json` in Project Root

**How it works:**
```json
{
  "venvPath": "/Users/marcelodeleon/Library/Caches/pypoetry/virtualenvs",
  "venv": "payment-hub-workflows-Pe1N7Nwj-py3.12"
}
```

**Pros:**
- Simple, standard Pyright configuration
- Benefits team members using VS Code (Pylance uses Pyright)
- Explicitly documents virtualenv location

**Cons:**
- Requires hardcoding virtualenv hash (e.g., `Pe1N7Nwj-py3.12`)
- Needs manual updates when Poetry recreates virtualenv
- Poetry venv names are machine-specific (different hash per machine)
- Team doesn't use neovim, limited benefit

**Decision:** ❌ Rejected - Maintenance burden, machine-specific hashes

### Option 2: Auto-Detect Poetry Venv in Neovim (CHOSEN)

**How it works:**
- Run `poetry env info --path` dynamically when Pyright starts
- Configure Pyright to use detected virtualenv
- No hardcoded paths, works across machines

**Pros:**
- No project repo changes needed
- Versioned in personal neovim dotfiles
- Works automatically after cloning project on different machines
- No maintenance when virtualenv hash changes
- Gracefully falls back for non-Poetry projects

**Cons:**
- Only benefits you (but team uses different editors anyway)
- Slightly more complex config (Lua code)

**Decision:** ✅ Chosen - Best fit for personal workflow, zero maintenance

### Option 3: Manual Virtualenv Activation

**How it works:**
- Run `poetry shell` before launching neovim
- Or: `source $(poetry env info --path)/bin/activate`

**Pros:**
- No configuration changes

**Cons:**
- Manual step every time
- Easy to forget
- Poor developer experience

**Decision:** ❌ Rejected - Too manual, error-prone

## Implementation: Neovim Auto-Detection

### Step 1: Add Poetry Venv Detection Function

Add this function to your LSP configuration file (e.g., `~/.neovim/lua/plugins/lsp.lua`):

```lua
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
```

### Step 2: Configure Pyright to Use Detected Venv

Modify your Pyright LSP setup:

```lua
-- Configure Pyright with Poetry venv detection
require('lspconfig').pyright.setup({
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
```

**Note:** If using lsp-zero, you can still call `require('lspconfig').pyright.setup()` directly to override the default configuration.

### Step 3: Restart Neovim

After making the changes:
1. Save the configuration file
2. Restart neovim or run `:LspRestart`

## How It Works

### Execution Flow

1. **Neovim opens a Python file** in a Poetry project
2. **Pyright LSP initialization** triggers the `before_init` hook
3. **Detection function runs**:
   ```bash
   cd /Users/marcelodeleon/projects/payment-hub-workflows && poetry env info --path
   ```
4. **Poetry returns venv path**:
   ```
   /Users/marcelodeleon/Library/Caches/pypoetry/virtualenvs/payment-hub-workflows-Pe1N7Nwj-py3.12
   ```
5. **Pyright configured** to use `{venv_path}/bin/python` as the Python interpreter
6. **Pyright discovers packages** in the Poetry virtualenv's site-packages directory

### Edge Cases Handled

- **Non-Poetry projects**: Function returns `nil`, Pyright uses default Python (graceful fallback)
- **Different machines**: Each machine detects its own Poetry venv hash
- **Multiple projects**: Works per-project automatically (uses `vim.fn.getcwd()`)
- **No Poetry installed**: `2>/dev/null` suppresses error, returns `nil`
- **Virtualenv changes**: Next neovim session automatically detects new venv

## Verification Steps

After implementing the fix:

### 1. Check LSP Log
```vim
:LspLog
```

Look for Pyright initialization messages showing the correct virtualenv path:
```
[INFO] Python path: /Users/marcelodeleon/Library/Caches/pypoetry/virtualenvs/payment-hub-workflows-Pe1N7Nwj-py3.12/bin/python
```

### 2. Test Import Resolution

Open a Python file with library imports:
```python
from galileo.lib.crypto import encrypt
from temporalio import workflow
```

**Expected:** No lint errors on these imports

### 3. Test Go-to-Definition

1. Place cursor on an imported symbol (e.g., `encrypt`)
2. Press `gd` (or your keybinding for go-to-definition)
3. **Expected:** Jumps to the function definition in the library source

### 4. Test Autocomplete

1. Type `from galileo.lib.` and wait for autocomplete
2. **Expected:** Shows available modules (e.g., `crypto`, `transaction`, etc.)

### 5. Test Type Hints

Hover over a library function:
```vim
:lua vim.lsp.buf.hover()
```

**Expected:** Shows function signature and docstring from the library

## Troubleshooting

### Issue: Still seeing import errors

**Check:**
1. Restart neovim completely (`:qa` and reopen)
2. Verify Poetry virtualenv exists:
   ```bash
   cd /path/to/project
   poetry env info --path
   ```
3. Check LSP log (`:LspLog`) for errors
4. Manually test the detection function:
   ```lua
   :lua print(vim.inspect(io.popen("cd " .. vim.fn.getcwd() .. " && poetry env info --path"):read("*a")))
   ```

### Issue: Function returns nil

**Possible causes:**
- Not in a Poetry project (check for `pyproject.toml`)
- Poetry not in PATH
- Virtualenv not created yet (run `poetry install`)

**Solution:**
```bash
cd /path/to/project
poetry install
poetry env info --path  # Verify it works
```

### Issue: Works for some projects but not others

**Cause:** Some projects might not use Poetry

**Solution:** This is expected behavior. The function gracefully falls back to default Python for non-Poetry projects.

### Issue: Pyright using wrong Python after config change

**Solution:**
1. Check if there's a `pyrightconfig.json` in the project root (takes precedence)
2. Remove or update `pyrightconfig.json` if present
3. Restart LSP: `:LspRestart`

## Benefits Realized

After implementing this solution:

✅ Import resolution works for all Poetry-installed packages
✅ Go-to-definition works on library symbols
✅ Autocomplete includes library functions and classes
✅ Type hints from libraries are recognized
✅ Zero maintenance when Poetry recreates virtualenv
✅ Works across different machines automatically
✅ No project repository changes needed
✅ Configuration versioned in personal dotfiles

## Related Resources

- [Pyright Configuration Documentation](https://github.com/microsoft/pyright/blob/main/docs/configuration.md)
- [Poetry Virtualenv Management](https://python-poetry.org/docs/managing-environments/)
- [neovim LSP Config - Pyright](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright)

## Tags

`#neovim` `#lsp` `#pyright` `#poetry` `#python` `#import-resolution`
