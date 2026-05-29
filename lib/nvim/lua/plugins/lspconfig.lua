--[[
    Description
        This plugin acts as the glue between Neovim's LSP client and your
        installed language servers by providing curated configurations for
        each LSP server. LSPConfig essentially provides a simple interface
        for us to configure LSP servers.

    Configuration
        Servers configs are localized in their own files. See lsp/servers
        for LSP servers and lsp/tools for linters and formatters.

    Dependencies
        mason
            See plugins/mason.lua
        cmp-nvim-lsp
            See plugins/nvim-cmp.lua
--]]

return {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
        'mason-org/mason.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        require('lsp.utils.diagnostics').setup()
        require('lsp')
    end,
}
