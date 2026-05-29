--[[
    Description
        Provides a navigable interface for your diagnosic messages, with
        the ability to search definitions, references, symbols and more.

    Keymaps
        Global
            <L>ff       n   View diagnostics
            <L>fb       n   View buffer diagnostics
            <L>fs       n   View symbols
            <L>fd       n   View definitions, references, etc...
            <L>fl       n   View location list
            <L>fx       n   View quickfix list
--]]

return {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    lazy = true,
    keys = {
        {
            '<leader>ff',
            '<cmd>Trouble diagnostics toggle<cr>',
            desc = 'Diagnostics (Trouble)',
            mode = 'n',
        },
        {
            '<leader>fb',
            '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
            desc = 'Buffer diagnostics (Trouble)',
            mode = 'n',
        },
        {
            '<leader>fs',
            '<cmd>Trouble symbols toggle focus=false<cr>',
            desc = 'Symbols (Trouble)',
            mode = 'n',
        },
        {
            '<leader>fd',
            '<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>',
            desc = 'LSP definitions / references / ... (Trouble)',
            mode = 'n',
        },
        {
            '<leader>fl',
            '<cmd>Trouble loclist toggle<cr>',
            desc = 'Location list (Trouble)',
            mode = 'n',
        },
        {
            '<leader>fx',
            '<cmd>Trouble qflist toggle<cr>',
            desc = 'Quickfix list (Trouble)',
            mode = 'n',
        },
    },
}
