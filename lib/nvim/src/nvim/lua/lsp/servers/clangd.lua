--[[
    Description
        C/C++ language server for Neovim.
--]]

local M = require('lsp.class').LspServer:new('Clangd')

-- vim.lsp.config(config) ------------------------
--------------------------------------------------

function M.config(capabilities)
    local config = {
        capabilities = capabilities or {},
        filetypes = {
            'c',
            'cpp',
        },
        cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
        },
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
        },
    }
    -- Neovim uses utf-16 encoding and does not permit multiple
    -- encoding offsets; clangd needs to use utf-16 instead of utf-8.
    -- https://www.lazyvim.org/extras/lang/clangd#nvim-lspconfig
    -- https://github.com/LazyVim/LazyVim/issues/3028
    config.capabilities['offsetEncoding'] = { 'utf-16' }
    return config
end

return M
