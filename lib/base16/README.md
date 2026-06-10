<h1 align=center>Base16 Shell Themes</h1>
<h3 align=center>Colorize your shell using shell aliases</h3>
<br>

Configures Worldshredder's fork of [Base16-Shell](https://github.com/worldshredder/base16-shell) for your shells, which includes additional themes and compatibility fixes for use with Neovim. For the original project, see: https://github.com/chriskempson/base16-shell

## Installation

```sh
lib/base16/src/install
```

If you want a specific default theme configured, use `-t THEME` or `--theme THEME`:

```sh
lib/base16/src/install --theme material-palenight
```

## Post-Install Configuration

### Changing Active Theme

The active theme is stored in `~/.base16_theme`. You can change your active theme via one of the `base16_<THEME_NAME>` aliases:

```sh
base16_rose-pine
```

### Changing Default Theme

To change your default theme, you have two options:

1. Reinstall the `lib/base16`

2. Update your shell's runtime config

    Replace the `base16_{DEFAULT_THEME}` call with your desired base16 alias. If you installed this library with [ws-env](https://github.com/worldshredder/ws-env) then you'll find your base16 configuration in `~/.shellrc.d/zzz_dotfiles_base16.sh`.

### Troubleshooting

If a shell editor or program is experiencing issues, you may need to unset the `BASE16_THEME` environment variable before running the program.

```sh
unset BASE16_THEME
```
