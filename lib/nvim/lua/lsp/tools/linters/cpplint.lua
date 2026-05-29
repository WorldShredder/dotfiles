--[[
    Description
        General purpose linter for C/C++.

        See lsp/servers/efm_ls.lua
        See lsp/README.md
--]]

local fs = require('utils.fs')
local sys = require('lsp.utils.sys')

local M = require('lsp.class').LspTool:new('cpplint')

local bin_path = fs.get_bin_path(M.name)
if not bin_path then
    return M
end

M.lang = { 'c', 'cpp' }

M.config = {
    prefix = M.name,
    lintSource = M.name,
    lintStdin = false,
    lintFormats = { '%.%#:%l: %m' },
    rootMarkers = {},
    lintCommand = sys.format_cmd(
        bin_path,
        '--filter="-legal/copyright,-whitespace/comments"',
        '"${INPUT}"'
    ),
}

return M
