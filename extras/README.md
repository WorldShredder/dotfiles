<h1 align=center>DotFiles</h1>
<h3 align=center>Component Extras</h3>
<br>

### nvim

- #### plugins/neocodeium.lua

    Enables the [Neocodeium](https://github.com/monkoose/neocodeium) plugin which implements [Windsurf AI](https://windsurf.com). This plugin is updated more frequently than [windsurf.nvim](https://github.com/exafunction/windsurf.nvim), but lacks Nvim-CMP integrations. A Windsurf API key is required for this plugin to function.

    #### Installation

    ```sh
    cp extras/nvim/plugins/neocodeium.lua ~/.config/nvim/lua/plugins
    ```

- #### plugins/windsurf.lua

    Enables the [windsurf.nvim](https://github.com/exafunction/windsurf.nvim) plugin which implements [Windsurf AI](https://windsurf.com). This plugin is infrequently updated but, unlike [Neocodeium](https://github.com/monkoose/neocodeium), provides Nvim-CMP integrations. A Windsurf API key is required for this plugin to function.

    #### Installation

    ```sh
    cp extras/nvim/plugins/windsurf.lua ~/.config/nvim/lua/plugins
    ```
