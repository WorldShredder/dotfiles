# Managing LSP Servers

This document describes how to configure new LSP servers and tools using classes provided by [lsp/class.lua](class.lua).

> [!NOTE]
> - Any server can be disabled by adding its name to the `exclude` table in [lsp/init.lua](init.lua).
> - Any LSP tool, e.g., _shellcheck_, can be disabled by adding its name to the `exclude` table in [lsp/servers/efm_ls.lua](servers/efm_ls.lua).

### Servers
This setup defines two server config types:

- **Server**: Standard language servers, such as `lua_ls`.
- **Meta Server**: A single server which manages or configures multiple servers or tools, such as `efm`.

### Classes

- #### `LspServer`

    Used for the configuration of a _server_ or _meta server_.

    #### Fields

    - `name` _string_

        **Type**: `string`

        The name of the LSP server being configured; passed to `vim.lsp.config()` and `vim.lsp.enable()`.

    - `config?`
        
        **Type**: `table<string, any>|fun(capabilities?: table): table<string, any>`

        Can be a `table` or a `function` which takes an optional `table` _capabilities_ and returns a `table`; passed to `vim.lsp.config()`.

    - `post_config?`

        **Type**: `table<string, function>`

        A table of functions to call after calling `vim.lsp.config()` and `vim.lsp.enable()`. This is where you would put any server-specific auto-commands and key maps.

    - `exclude?`
    
        **Type**: `string[]`

        A table of `post_config` keys to exclude from the post configuration operation.

    - `meta_exclude?`

        **Type**: `string[]`

        A table of LSP servers to exclude, if this is a meta config object. For example, if this is the config for `efm` and you were deciding between _cpplint_ and _cppcheck_, you can add the one you don't want to use to this table: `M.meta_exclude = { 'cpplint' }`

    - `disabled`

        **Type**: `boolean`

        Can be defined any time you want to exclude a given server from the module-scope itself.

    #### Usage

    ```lua
    -- Create a new LSP config object
    local M = require('lsp.class').LspServer:new('bashls')

    -- Optional management fields can be declared here
    M.disabled = false
    M.exclude = { 'run_me_too' }

    -- Main config
    M.config = {
        filetypes = {'sh', 'bash', 'zsh',},
        settings = {
            bashIde = { shellcheckArguments = '--color=never --format=gcc -e SC2024', },
        },
    }

    -- Optional post config functions
    M.post_config = {
        run_me_after_config = function() print('foo') end,
        run_me_too = function() print('bar') end,
    }

    return M
    ```

- #### `LspTool`

    Used for configuring LSP tools and is generally intended to be used by a _meta-config_ object. Some fields will remain dormant unless you handle them somewhere else, e.g., `post_config`, `exclude` and `disabled`. Alternatively you can use the `efm_lsp_config` if you're ok with less control.

    #### Fields

    - `name`

        **Type**: `string`

        The name of the LSP tool being configured; passed to, for example, `efm`.

    - `lang`

        **Type**: `string[]`

        A table of languages associated with this tool, e.g., `{'c', 'cpp'}`.

    - `config`

        **Type**: `table<string, any>|fun(): table<string, any>`

        Can be a `table` or a `function` that returns a `table`; passed to, for example, `efm`.

    - `post_config?`

        **Type**: `table<string, function>`

        A table of functions to call that are made available for a meta-config object to add to its `post_config` table. This is where you would put any tool-specific auto-commands and key maps.

    - `exclude?`
    
        **Type**: `string[]`

        A table of `post_config` keys to inform a meta-config which functions to exclude.

    - `meta_exclude?`

        **Type**: `string[]`

        A table of LSP servers to exclude, if this is a meta config object. For example, if this is the config for `efm` and you were deciding between _cpplint_ and _cppcheck_, you can add the one you don't want to use to this table: `M.meta_exclude = { 'cpplint' }`

    - `disabled`

        **Type**: `boolean`

        Can be defined any time you want to exclude a given tool from the module-scope itself. Note that this only informs whatever is handling this tool, e.g., `efm`, that you want to exclude the tool.

    #### Usage

    ```lua
    local fs = require('utils.fs')
    local sys = require('lsp.utils.sys')

    -- Create a new LSP tool config object
    local M = require('lsp.class').LspTool:new('luacheck')

    -- Optional management fields can be declared here
    M.disabled = false
    M.exclude = {'run_me_too'}

    -- Ensure tool exists on system PATH
    local bin_path = fs.get_bin_path(M.name)
    if not bin_path then
        return M
    end

    -- Declare associated language(s)
    M.lang = { 'lua' }

    -- Main config
    M.config = {
        prefix = M.name,
        lintSource = M.name,
        lintIgnoreExitCode = true,
        lintStdin = true,
        lintFormats = { '%.%#:%l:%c: (%t%n) %m' },
        rootMarkers = { '.luacheckrc' },
        lintCommand = sys.format_cmd(bin_path '--codes', '--no-color', '--quiet'),
    }

    -- Optional post config functions
    M.post_config = {
        run_me_after_config = function() print('foo') end,
        run_me_too = function() print('bar') end,
    }

    return M
    ```
