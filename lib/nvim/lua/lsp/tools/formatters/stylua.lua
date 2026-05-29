--[[
    Description
        Formatter for lua.

        See lsp/servers/efm_ls.lua
        See lsp/README.md
--]]

local fs = require('utils.fs')
local sys = require('lsp.utils.sys')

local M = require('lsp.class').LspTool:new('stylua')

local bin_path = fs.get_bin_path(M.name)
if not bin_path then
    return M
end

M.lang = { 'lua' }

M.config = {
    formatCanRange = true,
    formatStdin = true,
    rootMarkers = { 'stylua.toml', '.stylua.toml' },
    formatCommand = sys.format_cmd(
        bin_path,
        '--color Never',
        '${--range-start:charStart}',
        '${--range-end:charEnd}',
        "--stdin-filepath '${INPUT}'",
        '--indent-type Spaces',
        '--indent-width 4',
        '--quote-style AutoPreferSingle',
        '--column-width 88'
    ),
}

return M
