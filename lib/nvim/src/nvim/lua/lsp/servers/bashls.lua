--[[
    Description
        Bash language server for Neovim.

    Code Actions
        If you require code actions, you must use the Shellcheck linter that
        comes with bashls. To do this, perform the following:

            - Comment out `settings.bashIde.shellcheckPath` in `bashls.lua`
            - Uncomment `settings.bashIde.shellcheckArguments` in `bashls.lua`
            - (Optional) Exclude `shellcheck` in `efm` or set `M.disabled=true`
            - (Optional) Delete lsp/tools/linters/shellcheck.lua
--]]

local M = require('lsp.class').LspServer:new('BashLS')

-- vim.lsp.config(config) ------------------------
--------------------------------------------------

M.config = {
    filetypes = {
        'sh',
        'bash',
        'zsh',
    },
    settings = {
        bashIde = {
            -- shellcheckArguments = '--color=never --format=gcc -e SC2024',
            shellcheckPath = '',
        },
    },
}

return M
