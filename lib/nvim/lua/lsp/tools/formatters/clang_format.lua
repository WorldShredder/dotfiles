--[[
    Description
        Formatter for c and c++.

        See lsp/servers/efm_ls.lua
        See lsp/README.md
--]]

local fs = require('utils.fs')
local sys = require('lsp.utils.sys')

local M = require('lsp.class').LspTool:new('clang-format')

local bin_path = fs.get_bin_path(M.name)
if not bin_path then
    return M
end

M.lang = { 'c', 'cpp' }

M.config = {
    formatStdin = true,
    formatCommand = sys.format_cmd(bin_path),
}

return M
