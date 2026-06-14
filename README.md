<h1 align=center>DotFiles</h1>
<h3 align=center>WorldShredder Personal Collection</h3>
<br>

A personal collection of system configuration files. Tested in latest versions of _Debian_ and _Fedora_ only.

## Installation

The entire collection can be installed using the [ws-env](https://github.com/worldshredder/ws-env) workstation installer which utilizes [Planit](https://github.com/worldshredder/planit) and will handle all dependencies for you.

Alternatively, you can install each components manually. The [extras](/extras) directory contains drop-in components or application plugins to extend a given configuration. See [Extras README.md](/extras/README.md).

### Quickstart

For all options, see [WS-Env documentation](https://github.com/worldshredder/ws-env)

1. #### Clone WS-Env

    ```sh
    git clone --depth 1 https://github.com/worldshredder/ws-env
    ```

    ```sh
    cd ws-env/src
    ```

2. #### Run Installer

    #### Full install w/dependencies & Nerdfont symbols

    ```sh
    ./install --shell bash,zsh --lib dotfiles --purge --extras --binstall
    ```

    #### Full install w/specific Nerdfont

    Change `--nerdfonts-font jetbrainsmono,robotomono` to your desired font(s). See `--help` for Nerdfont options.

    ```sh
    ./install --shell bash,zsh --lib dotfiles --purge --extras --binstall --nerdfonts-font jetbrainsmono,robotomono
    ```

    #### Dotfiles only (no dependencies or fonts)

    ```sh
    ./install --lib dotfiles --exclude dotfiles
    ```

    #### Install a specific dotfiles library

    ```sh
    ./install --lib dotfiles --exclude dotfiles --dotfiles-lib ps1,nvim,base16
    ```

### Manual Install

> [!WARNING]
> It is recommended that you install dotfile libraries using [WS-Env](https://github.com/worldshredder/ws-env) to ensure necessary dependencies are installed.

Each library has an `install` script in its `src/` directory. Simply run that script to install your desired library.

For example, to install the _ps1_ library (Nerdfont required), run:

```sh
lib/ps1/src/install
```

## Documenation

Some library components will have a `README.md` detailing what they offer. You can find a full list of these docs [here](/lib/README.md).
