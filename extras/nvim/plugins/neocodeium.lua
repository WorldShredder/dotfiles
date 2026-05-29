--[[
    Description
        Provides AI autocompletions through the Windsurf API.

        Unlike other Windsurf plugins, NeoCodeium provides no Nvim-Cmp
        integration (don't ask me why). As such, either NeoCodeium or
        Nvim-Cmp should be configured in 'manual' mode.

        See 'Plugin Priority' below.

    Requirements
        This plugin requires a Windsurf API. You can get an API key for free
        from Windsurf after signing up for an account.

        See https://windsurf.com

    Plugin Priority
        To ensure only one of Nvim-Cmp and Codeium is actively providing
        completions, you must set the `auto_slop_mode` variable:

            auto_slop_mode = false
                - Nvim-Cmp takes priority
                - Codeium is configured in manual mode
                - Codeium will provide completions upon <A-j>

            auto_slop_mode = true
                - Codeium takes priority
                - Nvim-Cmp is configured in manual mode
                - Nvim-Cmp will provide completions upon <A-c>

    Dependencies
        plenary
            Provides helper functions for plugin authors.
        nvim-cmp
            See plugins/nvim-cmp.lua

    Keymaps
        Neocodeium
            <A-e>       i   Accept completion
            <A-w>       i   Accept next completion word
            <A-l>       i   Accept next completion line
            <A-x>       i   Clear completions
            <A-j>       i   Next completion
                            Request completions
                            Abort Nvim-Cmp
            <A-k>       i   Previous completion
            <L><L>c     n   Toggle plugin on|off
        Nvim-Cmp
            <A-c>       i   Request completions
                            Abort Codeium
--]]

local auto_slop_mode = false

return {
    'monkoose/neocodeium',
    event = 'VeryLazy',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'hrsh7th/nvim-cmp',
    },
    config = function()
        local neocodeium = require('neocodeium')

        local manual = true
        local filter = function()
            return true
        end

        if auto_slop_mode then
            local cmp = require('cmp')
            local cmp_config = require('cmp.config')

            cmp.event:on('menu_opened', function()
                require('neocodeium').clear()
            end)

            cmp_config.set_global({
                completion = {
                    autocomplete = false,
                },
            })

            filter = function()
                return not require('cmp').visible()
            end

            -- keybind: enable cmp
            vim.keymap.set('i', '<A-c>', function()
                require('cmp').complete()
            end)

            manual = false
        else
            vim.api.nvim_create_autocmd('User', {
                pattern = 'NeoCodeiumCompletionDisplayed',
                callback = function()
                    require('cmp').abort()
                end,
            })
        end

        -- additional status messages
        vim.api.nvim_create_autocmd('User', {
            pattern = 'NeoCodeiumEnabled',
            callback = function()
                vim.notify('Codeium enabled', vim.log.levels.INFO)
            end,
        })
        vim.api.nvim_create_autocmd('User', {
            pattern = 'NeoCodeiumDisabled',
            callback = function()
                vim.notify('Codeium disabled', vim.log.levels.INFO)
            end,
        })

        local config = {
            enabled = true,
            manual = manual, -- manually request completion
            show_label = true, -- num suggestions in ln num column
            debounce = false, -- show suggestions while typing if false
            max_lines = 10000, -- num parsed buffer lines
            silence = false, -- silence non-important messages
            disable_in_special_buftypes = true,
            log_level = 'warn',
            single_line = {
                -- collapse multi-line suggestions into one-line
                enabled = false,
                label = '...',
            },
            -- buffer filter; or always return true to accept all buffers
            filter = filter,
            filetypes = {
                help = false,
                gitcommit = false,
                gitrebase = false,
                markdown = false,
                text = false,
                ['.'] = false,
            },
            root_dir = {
                '.git',
                'package.json',
                'CmakeLists.txt',
                'compile_commands.json',
            },
        }
        neocodeium.setup(config)
    end,
    keys = {
        {
            '<leader><leader>c',
            '<cmd>NeoCodeium toggle<cr>',
            desc = 'Toggle on/off (NeoCodeium)',
            mode = 'n',
        },
        {
            '<A-e>',
            function()
                require('neocodeium').accept()
            end,
            desc = 'Accept suggestion (NeoCodeium)',
            mode = 'i',
        },
        {
            '<A-x>',
            function()
                require('neocodeium').clear()
            end,
            desc = 'Clear suggestion (NeoCodeium)',
            mode = 'i',
        },
        {
            '<A-w>',
            function()
                require('neocodeium').accept_word()
            end,
            desc = 'Accept word (NeoCodeium)',
            mode = 'i',
        },
        {
            '<A-l>',
            function()
                require('neocodeium').accept_line()
            end,
            desc = 'Accept line (NeoCodeium)',
            mode = 'i',
        },
        {
            '<A-j>',
            function()
                require('neocodeium').cycle_or_complete(1)
            end,
            desc = 'Next suggestion (NeoCodeium)',
            mode = 'i',
        },
        {
            '<A-k>',
            function()
                require('neocodeium').cycle(-1)
            end,
            desc = 'Previous suggestion (NeoCodeium)',
            mode = 'i',
        },
    },
}
