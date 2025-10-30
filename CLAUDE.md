# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration repository using Lua. The configuration uses `lazy.nvim` as the plugin manager and is structured with a modular approach. The repository is stored at `~/.neovim` and symlinked to `~/.config/nvim` via the `install` script.

## Installation & Setup

**Initial setup:**
```bash
./install
```

This script creates symlinks from `~/.neovim` to `~/.config/nvim` and installs the Dracula Pro theme to the appropriate location (`~/.local/share/nvim/site/pack/themes/start/dracula_pro`).

**Plugin management:**
- Plugins are managed by `lazy.nvim` (auto-bootstrapped in `lua/marce/plugins.lua:1-13`)
- On first Neovim launch, lazy.nvim will automatically install all plugins
- Use `:Lazy` in Neovim to manage plugins (update, install, clean)

**LSP setup:**
- LSP servers are managed via Mason (`after/plugin/lsp.lua`)
- Currently configured servers: `tsserver` (TypeScript) and `pyright` (Python)
- Mason auto-installs these servers on first run
- To add a new language server, add it to `ensure_installed` in `after/plugin/lsp.lua:7`

## Architecture

### Configuration Loading Order

1. `init.lua` - Entry point, sets leader key and requires core modules
2. `lua/marce/theme.lua` - Loads Dracula Pro theme with markdown highlight fixes
3. `lua/marce/keymaps.lua` - Core key mappings
4. `lua/marce/set.lua` - Vim options and settings
5. `lua/marce/plugins.lua` - Plugin definitions via lazy.nvim
6. `lua/marce/telescope.lua` - Telescope configuration and custom functions
7. `after/plugin/*.lua` - Plugin-specific configurations (loaded after plugins)

### Module Structure

**Core modules** (`lua/marce/`):
- `plugins.lua` - All plugin definitions with lazy.nvim
- `set.lua` - Vim options (line numbers, indentation, clipboard, etc.)
- `keymaps.lua` - Global key mappings independent of plugins
- `theme.lua` - Color scheme setup with Dracula Pro markdown fixes
- `telescope.lua` - Telescope setup and custom helper functions

**Plugin configurations** (`after/plugin/`):
- `lsp.lua` - LSP Zero setup with Mason, completion, and LSP keybindings
- `treesitter.lua` - Treesitter configuration for syntax highlighting
- `null-ls.lua` - Formatting and linting (black, prettier, flake8, eslint)
- `obsidian.lua` - Obsidian vault integration for note-taking
- `telescope.lua` - Telescope keybindings (separate from config)
- `noice.lua` - Enhanced UI for messages, cmdline, and popupmenu
- `fugitive.lua` - Git integration keybindings

### Key Technical Decisions

**Indentation:**
- Default: 4 spaces (set in `lua/marce/set.lua:4-6`)
- JS/TS override: 2 spaces (autocmd in `lua/marce/set.lua:9-11`)

**Dracula Pro Theme:**
- Manually installed in `draculapro/` directory (not via plugin manager)
- Custom markdown highlight groups added in `lua/marce/theme.lua:16-39` to fix Treesitter compatibility
- Theme files are excluded from the install script (`install:9`)

**LSP Configuration:**
- Uses `lsp-zero.nvim` preset for simplified setup
- Mason auto-configures installed servers via `setup_handlers`
- Custom keybindings on LSP attach (gd, K, [d, ]d, etc.) in `after/plugin/lsp.lua:50-63`

**Python Integration:**
- Respects `VIRTUAL_ENV` for Python host program (`lua/marce/set.lua:31-33`)
- Configured with pyright LSP, black formatter, flake8 linter, and isort

**Obsidian Integration:**
- Vault location: `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes/second-brain`
- Custom frontmatter with `id`, `aliases`, `tags`, `area`, `project` fields
- Wiki-style links enabled with custom link function
- Leader mappings: `<leader>o` prefix (on, oo, os, ob, ot, of, od)

## Common Tasks

**Testing configuration changes:**
```
# After editing a Lua file
:source %              # or use <leader>so keymap
```

**Updating plugins:**
```
:Lazy update
```

**Installing new LSP server:**
1. Add server name to `ensure_installed` in `after/plugin/lsp.lua:7`
2. Restart Neovim - Mason will auto-install

**Adding custom telescope searches:**
- Add function to `lua/marce/telescope.lua` (see `M.edit_neovim()` as example)
- Add keymap in `after/plugin/telescope.lua`

**Formatting:**
- `<leader>p` - Run prettier on current buffer
- null-ls auto-formats on save (configured in `after/plugin/null-ls.lua`)

## Key Mappings

**Leader key:** Space

**Navigation:**
- `<C-J/K/L/H>` - Split navigation (also works with tmux via vim-tmux-navigator)
- `<C-P>` - Git files search (Telescope)
- `<leader>f` - Find files (Telescope)
- `<leader>gg` - Live grep (Telescope)
- `<leader>n` - Edit Neovim config (Telescope)

**File operations:**
- `<leader>s` - Save file
- `<leader>w` - Close window
- `<leader>e` - Open netrw explorer

**LSP (when attached):**
- `gd` - Go to definition
- `K` - Hover documentation
- `[d` / `]d` - Next/previous diagnostic
- `<leader>vca` - Code actions
- `<leader>vrr` - References
- `<leader>vrn` - Rename

**Git:**
- Git commands available via fugitive (`:G` prefix)
- `<leader>gb` - Git branches (Telescope)

## Important Notes

- This configuration targets macOS/Linux (install script uses platform-specific find commands)
- Undo files persist at `~/.vim/undodir` (ensure directory exists)
- Clipboard integration uses system clipboard (`unnamed`)
- Color column set at 88 characters (Python convention)
- Treesitter parsers auto-install on buffer enter for: lua, python, typescript, markdown
