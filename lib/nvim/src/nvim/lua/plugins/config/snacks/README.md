# Managing Snack Modules

This document describes how to configure new [snack](https://github.com/folke/snacks.nvim) modules for [plugins/snacks.lua](../../snacks.lua).

## Snacks Module Fields

The following fields define a module:

- `pre_config`

    **Type**: `table<string, any>`

    This table is passed as the module's main config to `snacks.setup()`. Module specific settings, see [Snacks docs](https://github.com/folke/snacks.nvim/tree/main/docs).

- `post_config?`

    **Type**: `table<string, function>`

    A table of functions to call after calling `snacks.setup()`. This is where you can define module-specific auto-commands, non-standard key maps, and other function definitions that rely on module fields.

- `picker_config?`

    **Type**: `table<string, any>`

    This table is ignored by `plugins/snacks.lua` and is only documented here per convention. You can use this table to define picker-specific settings and include it in the main [picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md) module's config. For example, defining picker settings for the [explorer](https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md) to include in the `picker.sources` table.

- `keys`

    **Type**: `table[]`

    A table of keymap tables passed to the `snacks.keys`; See [Lazy Nvim Keymaps](https://lazy.folke.io/spec/lazy_loading#%EF%B8%8F-lazy-key-mappings).

- `exclude`

    **Type**: `string[]`

    A table of `post_config` keys to exclude during the setup, thus providing a clean method of managing your post-config calls.

- `disabled`

    **Type**: `boolean`

    Can be defined any time you want to exclude a given module from the module-scope itself.

## Getting Started

The first thing we need to do is create a `.lua` file in [plugins/config/snacks](./), giving it the same name as the Snack module you're configuring. For example, if configuring the `Snacks.input` module, the file would be `plugins/config/snacks/input.lua`.

#### Define Module

```lua
-- Define module with optional fields
local M = {
    disabled = false,
    exclude = {}
}

-- Define the primary config
M.pre_config = {
    animate = { enabled = false },
}

-- Define any post-config setup functions
M.post_config = {
    md_off = function()
        vim.g.snacks_indent = true
        vim.api.nvim_create_autocmd('BufRead', {
            pattern = '*.md',
            group = vim.api.nvim_create_augroup(
                'MdIndentOff',
                { clear = true }
            ),
            callback = function()
                Snacks.indent.disable()
                vim.g.snacks_indent = false
            end,
        })
    end,
}

-- Define any keymaps
M.keys = {
    {
        '<leader>I',
        function()
            if vim.g.snacks_indent then
                Snacks.indent.disable()
                vim.g.snacks_indent = false
            else
                Snacks.indent.enable()
                vim.g.snacks_indent = true
            end
        end,
        desc = 'Toggle indentation guide (Snacks.indent)',
        mode = 'n',
    },
}

-- Return the module
return M
```

If we wanted to disable the post-config function `md_off`, we would add it to our `exclude` table like so:

```lua
local M = {
    disabled = false,
    exclude = {
        'md_off',
    }
}
```

