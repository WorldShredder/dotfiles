--[[
    Description
        Formatter for bash/sh.

        See lsp/servers/efm_ls.lua
        See lsp/README.md
--]]

local fs = require('utils.fs')
local sys = require('lsp.utils.sys')

local M = require('lsp.class').LspTool:new('shfmt')

local bin_path = fs.get_bin_path(M.name)
if not bin_path then
    return M
end

M.lang = { 'sh' }

M.config = {
    lintStdin = true,
    formatStdin = true,
    formatCommand = sys.format_cmd(
        bin_path,
        '--binary-next-line',
        '--case-indent',
        '--space-redirects',
        '--indent 4',
        "-filename '${INPUT}'"
    ),
}

return M
