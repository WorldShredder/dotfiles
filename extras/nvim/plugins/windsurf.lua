--[[
    Description
        Provides AI auto-completions through the Windsurf API and optional
        sources for Nvim-Cmp integration.

    Requirements
        This plugin requires a Windsurf API. You can get an API key for free
        from Windsurf after signing up for an account.

        See: https://windsurf.com

    Dependencies
        plenary
            Provides helper functions for plugin authors.
        nvim-cmp
            See plugins/nvim-cmp.lua

    Keymaps
        Windsurf
            <A-e>       i   Accept completion
            <A-w>       i   Accept next completion word
            <A-l>       i   Accept next completion line
            <A-x>       i   Clear completions
            <A-j>       i   Next completion
            <A-k>       i   Previous completion
            <L><L>c     n   Toggle plugin on|off
--]]

return {
    'Exafunction/windsurf.nvim',
    event = 'BufEnter',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'hrsh7th/nvim-cmp',
    },
    keys = {
        {
            '<leader><leader>c',
            '<cmd>Codeium Toggle<cr>',
            desc = 'Toggle Codeium (Windsurf)',
            mode = 'n',
        },
    },
    config = function()
        -- add codeium to cmp sources and menu
        local cmp_manage = require('plugins.config.nvim-cmp.manage')
        cmp_manage.add_source('codeium', '')

        require('codeium').setup({
            enterprise_mode = false,
            enable_chat = true,
            workspace_root = {
                use_lsp = true,
            },
            virtual_text = {
                enabled = false,
                default_filetype_enabled = true,
                filetypes = {
                    markdown = false,
                    text = false,
                },
                idle_delay = 100,
                virtual_text_priority = 65535,
                map_keys = true,
                key_bindings = {
                    accept = '<A-e>',
                    accept_word = '<A-w>',
                    accept_line = '<A-l>',
                    clear = '<A-x>',
                    next = '<A-j>',
                    prev = '<A-k>',
                },
            },
        })
    end,
}
