--[[
    Description
        Lua language server for Neovim.

        See lsp/README.md

    Code Actions
        If you require code actions, you must use the Luacheck linter that
        comes with lua_ls. To do this, perform the following:

            - Enable `diagnostics.enable` in `.luarc.json`
            - (Optional) Exclude `luacheck` or set `M.disabled=true`
            - (Optional) Delete lsp/tools/linters/luacheck.lua
--]]

local M = require('lsp.class').LspServer:new('lua_ls')

M.config = function(capabilities)
    local config = {
        capabilities = capabilities or {},
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = {
                        vim.fn.expand('$VIMRUNTIME/lua'),
                        vim.fn.expand('$XDG_CONFIG_HOME') .. '/nvim/lua',
                    },
                },
            },
        },
    }
    return config
end

return M
