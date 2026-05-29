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

    #### Full Install w/Nerdfont

    ```sh
    ./install --shell bash,zsh --nf-fonts robotomono,jetbrainsmono
    ```

    #### Dotfiles Only w/Dependencies & Fonts

    ```sh
    ./install \
        --shell bash,zsh \
        --lib dotfiles,nerdfonts \
        --nf-fonts robotomono,jetbrainsmono
    ```

    #### List Available Fonts

    ```sh
    ./install --lib nerdfonts --nf-list
    ```

## Documenation

Some library components will have a `README.md` detailing what they offer. You can find a full list of these docs [here](/lib/README.md).
