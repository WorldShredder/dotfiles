--[[
    Description
        Static analysis and bug detection tool for Bash.

        See lsp/servers/efm_ls.lua
        See lsp/README.md

    Code Actions
        If you require code actions, you must use the Shellcheck linter that
        comes with bashls. To do this, perform the following:

            - Comment out `settings.bashIde.shellcheckPath` in `bashls.lua`
            - Uncomment `settings.bashIde.shellcheckArguments` in `bashls.lua`
            - (Optional) Exclude `shellcheck` in `efm` or set `M.disabled=true`
            - (Optional) Delete lsp/tools/linters/shellcheck.lua
--]]

local fs = require('utils.fs')
local sys = require('lsp.utils.sys')

local M = require('lsp.class').LspTool:new('shellcheck')

local bin_path = fs.get_bin_path(M.name)
if not bin_path then
    return M
end

M.lang = { 'sh' }

M.config = {
    prefix = M.name,
    lintSource = M.name,
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {
        '-:%l:%c: %trror: %m',
        '-:%l:%c: %tarning: %m',
        '-:%l:%c: %tote: %m',
    },
    rootMarkers = {},
    lintCommand = sys.format_cmd(bin_path, '--color=never', '--format=gcc'),
}

return M
