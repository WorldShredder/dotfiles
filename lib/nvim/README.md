<h1 align=center>Neovim Lua Config</h1>
<h3 align=center>Lazy-Nvim, LSP-Config, Mason & More</h3>
<br>

This Neovim config features 9 core plugins, 2 QoL plugins, and _Base16_ for themes.

See [here](src/nvim/docs/bindings.md) for custom bindings.

## Plugins

1. [Lazy Nvim](https://lazy.folke.io/)
2. [Lualine](https://github.com/nvim-lualine/lualine.nvim)
3. [LSP-Config](https://github.com/neovim/nvim-lspconfig)
4. [Mason](https://github.com/mason-org/mason.nvim)
5. [Treesitter](https://github.com/neovim-treesitter/nvim-treesitter)
6. [Trouble](https://github.com/folke/trouble.nvim)
7. [Gitsigns](https://github.com/lewis6991/gitsigns.nvim)
8. [WebDev Icons](https://github.com/nvim-tree/nvim-web-devicons)
9. [Nvim-CMP](https://github.com/hrsh7th/nvim-cmp)
10. [Snacks](https://github.com/folke/snacks.nvim)
    - Dashboard
    - Explorer
    - Indent
    - Notifier
    - Picker
12. [Mini-Nvim](https://github.com/nvim-mini/mini.nvim)
    - Mini-Pairs
    - Mini-Comment
    - Mini-Surround
    - Mini-Move
    - Mini-Splitjoin
    - Mini-Align
13. [Base16 (Themes)](https://github.com/RRethy/base16-nvim)

## Custom Features

### Neovim Commandline

Control of the commandline is first given to `Snacks.input` before Neovim to maintain editor aesthetics. Pressing `:` starts a `Snacks.input` instance in _command mode_. Pressing `:` again will transfer control to Neovim's commandline, while pressing `BACKSPACE` when the input line is empty will close the `Snacks.input` instance.

### Macro Notifications

Starting a macro with `q<KEY>` will call `Snacks.notify` to display a notification containing macro info during the recording. A second notification will be displayed when the recording ends before disappearing.

### LSP Server Configuration

LSP servers and tools (EFM) are included into the main config programatically using simple utility classes. Configs are stored in designated directories which are subsequently parsed by the `lsp/init.lua` meta config. See [lsp/README.md](src/nvim/lua/lsp/README.md) for usage.

### Snacks Configuration

Snacks sub-modudles are included into the main Snacks config programatically. Sub-module configs are defined in `plugins/config/snacks`. See [plugins/config/snacks/README.md](src/nvim/lua/plugins/config/snacks/README.md) for usage.

## Installation

You can install manually or run the following command to install to `${HOME}/.config/nvim`

```sh
src/install
```
