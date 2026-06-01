--[[
    Description
        Static analysis and bug detection tool for C/C++.

        See lsp/servers/efm_ls.lua
        See lsp/README.md
--]]

local fs = require('utils.fs')
local sys = require('lsp.utils.sys')

local M = require('lsp.class').LspTool:new('cppcheck')

local bin_path = fs.get_bin_path(M.name)
if not bin_path then
    return M
end

M.lang = { 'c', 'cpp' }

M.config = {
    prefix = M.name,
    lintSource = M.name,
    lintStdin = false,
    lintFormats = { '%f:%l:%c: %m' },
    rootMarkers = { 'CmakeLists.txt', 'compile_commands.json', '.git' },
    lintCommand = sys.format_cmd(
        bin_path,
        '--quiet',
        '--force',
        '--enable=all',
        '--error-exitcode=1',
        '"${INPUT}"'
    ),
}

return M
