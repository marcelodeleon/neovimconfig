# Neovim Configuration

A modular Neovim configuration built with Lua, featuring LSP support, fuzzy finding, Git integration, and the Dracula Pro theme.

## Features

- **LSP Support** - Full language server integration with autocompletion, diagnostics, and code actions
- **Fuzzy Finding** - Telescope-powered file and text search with custom functions
- **Git Integration** - Fugitive for Git operations with custom keybindings
- **Modern Syntax Highlighting** - Treesitter-based parsing for accurate highlighting
- **Formatting & Linting** - Automatic code formatting with Prettier, Black, and ESLint
- **Obsidian Integration** - Note-taking workflow with wiki-style links
- **Tmux Navigation** - Seamless split navigation between Neovim and Tmux

## Installation

### Prerequisites

- Neovim >= 0.9
- Git
- [Dracula Pro](https://draculatheme.com/pro) theme (place in `draculapro/` directory)

### Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/.neovim.git ~/.neovim

# Run the install script
cd ~/.neovim
./install
```

The install script will:
- Create symlinks from `~/.neovim` to `~/.config/nvim`
- Copy Dracula Pro theme to the appropriate location

On first launch, lazy.nvim will automatically bootstrap and install all plugins.

## Plugin Management

Plugins are managed via [lazy.nvim](https://github.com/folke/lazy.nvim).

| Command | Description |
|---------|-------------|
| `:Lazy` | Open plugin manager |
| `:Lazy update` | Update all plugins |
| `:Lazy sync` | Sync plugins (install missing, remove unused) |

## Language Support

### Configured LSP Servers

| Language | Server | Features |
|----------|--------|----------|
| TypeScript/JavaScript | tsserver | Completion, diagnostics, go-to-definition |
| Python | pyright | Type checking, completion, Poetry venv support |

LSP servers are managed by Mason and auto-install on first run.

### Adding a New Language Server

1. Add the server name to `ensure_installed` in `after/plugin/lsp.lua`
2. Restart Neovim - Mason will auto-install the server

### Formatters & Linters

| Tool | Language | Type |
|------|----------|------|
| Black | Python | Formatter |
| isort | Python | Import sorter |
| Prettier | JS/TS | Formatter |
| Flake8 | Python | Linter |
| ESLint | JS/TS | Linter |

## Key Mappings

**Leader Key:** `Space`

### Navigation

| Mapping | Description |
|---------|-------------|
| `<C-h/j/k/l>` | Navigate splits (works with Tmux) |
| `<C-p>` | Search git files |
| `<leader>f` | Find files |
| `<leader>gg` | Live grep |
| `<leader>n` | Edit Neovim config |
| `<leader>e` | Open file explorer (netrw) |

### File Operations

| Mapping | Description |
|---------|-------------|
| `<leader>s` | Save file |
| `<leader>w` | Close window |
| `<leader>so` | Source current file |
| `<leader>p` | Format with Prettier |

### LSP (when attached)

| Mapping | Description |
|---------|-------------|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `[d` / `]d` | Previous/next diagnostic |
| `<leader>vca` | Code actions |
| `<leader>vrr` | Show references |
| `<leader>vrn` | Rename symbol |
| `<leader>vd` | Open diagnostic float |

### Git (Fugitive)

| Mapping | Description |
|---------|-------------|
| `<leader>gs` | Git status |
| `<leader>gb` | Git branches |
| `<leader>g0` | Git log |
| `<leader>g-` | Git log (current file) |

### Obsidian

| Mapping | Description |
|---------|-------------|
| `<leader>on` | New note |
| `<leader>oo` | Search notes |
| `<leader>os` | Quick switch |
| `<leader>ob` | Backlinks |
| `<leader>of` | Follow link |
| `<leader>od` | Toggle checkbox |

## Directory Structure

```
~/.neovim/
├── init.lua                 # Entry point
├── install                  # Setup script
├── lua/marce/
│   ├── plugins.lua          # Plugin definitions (lazy.nvim)
│   ├── set.lua              # Vim options
│   ├── keymaps.lua          # Core keymaps
│   ├── theme.lua            # Theme configuration
│   └── telescope.lua        # Telescope setup
├── after/plugin/
│   ├── lsp.lua              # LSP configuration
│   ├── null-ls.lua          # Formatters/linters
│   ├── treesitter.lua       # Syntax highlighting
│   ├── telescope.lua        # Telescope keymaps
│   ├── obsidian.lua         # Obsidian integration
│   ├── noice.lua            # UI enhancements
│   └── fugitive.lua         # Git keymaps
└── draculapro/              # Theme files (not tracked)
```

## Configuration Details

### Editor Settings

- **Indentation:** 4 spaces (2 for JS/TS)
- **Color column:** 88 characters
- **Line numbers:** Absolute + relative
- **Clipboard:** System clipboard enabled
- **Undo:** Persistent undo at `~/.vim/undodir`

### Python

- Respects `VIRTUAL_ENV` environment variable
- Poetry project detection for pyright
- Black formatter (88 char line length)

### Theme

Dracula Pro with custom fixes for:
- Treesitter markdown highlight groups
- Diff highlighting for better contrast in Fugitive

## Troubleshooting

### LSP not working

1. Run `:LspInfo` to check server status
2. Run `:Mason` to verify server installation
3. Check `:messages` for errors

### Plugins not loading

1. Run `:Lazy` to check plugin status
2. Try `:Lazy sync` to reinstall
3. Delete `~/.local/share/nvim/lazy` and restart

### Treesitter errors

Run `:TSUpdate` to update parsers, or `:TSInstall <language>` to install specific parsers.

## License

MIT
