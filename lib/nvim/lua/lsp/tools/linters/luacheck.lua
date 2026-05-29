--[[
    Description
        Static analysis and bug detection tool for Lua.

        See lsp/servers/efm_ls.lua
        See lsp/README.md

    Code Actions
        If you require code actions, you must use the Luacheck linter that
        comes with lua_ls. To do this, perform the following:

            - Enable `diagnostics.enable` in `.luarc.json`
            - (Optional) Exclude `luacheck` in `efm` or set `M.disabled=true`
            - (Optional) Delete lsp/tools/linters/luacheck.lua
--]]

local fs = require('utils.fs')
local sys = require('lsp.utils.sys')

local M = require('lsp.class').LspTool:new('luacheck')

local bin_path = fs.get_bin_path(M.name)
if not bin_path then
    return M
end

M.lang = { 'lua' }

M.config = {
    prefix = M.name,
    lintSource = M.name,
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { '%.%#:%l:%c: (%t%n) %m' },
    rootMarkers = { '.luacheckrc' },
    lintCommand = sys.format_cmd(bin_path, '--codes', '--no-color', '--quiet'),
}

return M
