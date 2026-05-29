--[[
    Description
        Provides an interface for auto-completions from given sources, such
        as Language Servers (LSP), buffers, system paths, function signatures,
        code snippets, and most LLM APIs.

    Snippets
        The configured snippet engine is provided by Lua Snip with additional
        completions provided by Friendly Snippets.

    Managing Sources
        Use `add_source()` from plugins/config/nvim-cmp/manage.lua to add new
        sources and menu entries to cmp from your source config's local scope.

        Example
            local mng = require('plugins.config.nvim-cmp.manage')
            mng.add_source('my_source', '󰐱')

    Dependencies
        lspkind
            Adds pictograms to completion menu items.
        LuaSnip
            Completion engine for Nvim-Cmp.
        cmp_luasnip
            LuaSnip completion source for Nvim-Cmp
        friendly-snippets
            Library of helpful snippets
        cmp-nvim-lsp
            Completion source for LSPs
        cmp-buffer
            Completion source for buffers
        cmp-path
            Completion source for system paths
        cmp-nvim-lsp-signature-help
            Completion source for function signatures

    Keymaps
        Nvim-Cmp
            <L>hf       n   Next hunk
            <C-j>       i   Select next completion
            <C-k>       i   Select previous completion
            <C-u>       i   Scroll up documentation preview
            <C-d>       i   Scroll down documentation preview
            <C-Space>   i   Confirm selection
            <C-e>       i   Abort Nvim-Cmp
--]]

return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'onsails/lspkind.nvim',
        'saadparwaiz1/cmp_luasnip',
        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*', -- pin to latest release
            build = 'make install_jsregexp', -- optional
        },
        'rafamadriz/friendly-snippets', -- snip collection
        'hrsh7th/cmp-nvim-lsp', -- source for autocomplete
        'hrsh7th/cmp-buffer', -- source from buffer
        'hrsh7th/cmp-path', -- source for fs paths
        'hrsh7th/cmp-nvim-lsp-signature-help', -- function sigs
    },
    config = function()
        -- local lspkind = require('lspkind')
        local luasnip = require('luasnip')
        local cmp = require('cmp')

        -- Global here since the `format` key is a function not a table
        -- See plugins/config/nvim-cmp/manage.lua
        vim.g.nvim_cmp_global_menu = {}

        -- friendly-snippets requires vscode-snippet formatting
        require('luasnip.loaders.from_vscode').lazy_load()

        local lspkind_width = function()
            return math.floor(vim.o.columns * 0.35)
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = {
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                    col_offset = -3,
                    side_padding = 0,
                },
            },
            formatting = {
                fields = { 'menu', 'icon', 'abbr', 'kind' },
                format = function(entry, vim_item)
                    local T = require('utils.tables')
                    local lspkind = require('lspkind')
                    local default_items = {
                        luasnip = '',
                        buffer = '',
                        path = '',
                        nvim_lsp = '',
                    }
                    local kind = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = {
                            menu = lspkind_width(),
                            abbr = lspkind_width(),
                        },
                        menu = T.ext_pairs(
                            vim.g.nvim_cmp_global_menu,
                            default_items
                        ),
                    })(entry, vim_item)
                    kind.icon = ' ' .. (kind.icon or '') .. ' '
                    kind.kind = '  (' .. (kind.kind or '') .. ')'
                    return kind
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
                ['<C-e>'] = cmp.mapping.abort(),
            }),
            sources = {
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'nvim_lsp_signature_help' },
            },
        })
    end,
}
