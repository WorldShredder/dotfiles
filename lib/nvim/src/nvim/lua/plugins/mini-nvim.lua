--[[
    Description
        Provides a number of very useful QOL mini-plugins.

    Modules
        mini.pairs      Create matching pairs as you type, e.g., {}, [], ''.
        mini.comments   Comment out one or more lines.
        mini.move       Move one or more lines while maintaining indentation.
        mini.splitjoin  Split/join bracket content.
        mini.align      Align two or more lines given a delimiter or column.

    Keymaps
        Global
            mini.comments
                <L>d        n,v     Toggle comments on selection
            mini.surround (see docs)
                h           n,v     Back-match modifier
                l           n,v     Forward-match modifier
                sa          n,v     Surround prefix
                sr          n,v     Replace prefix
            mini.move
                <C-h>       n,v     Move selection left
                <C-l>       n,v     Move selection right
                <C-j>       n,v     Move selection down
                <C-k>       n,v     Move selection up
            mini.splitjoin
                <L>J        n,v     Split/join bracketed content
            mini.align
                ga          v       Start alignment
                gp          v       Start alignment w/instant preview
                g[a|p]{SEP} v       Align by separator
                g[a|p]{POS} v       Justify to position l|c|r
--]]

return {
    'nvim-mini/mini.nvim',
    version = '*',
    config = function()
        require('mini.pairs').setup()
        require('mini.comment').setup({
            mappings = {
                comment = '<leader>d',
                comment_line = '<leader>d',
                comment_visual = '<leader>d',
                textobject = '<leader>d',
            },
        })
        require('mini.surround').setup({
            mappings = {
                suffix_last = 'h',
                suffix_next = 'l',
            },
        })
        require('mini.move').setup({
            mappings = {
                -- Visual Mode
                left = '<C-h>',
                right = '<C-l>',
                up = '<C-k>',
                down = '<C-j>',
                -- Normal Mode
                line_left = '<C-h>',
                line_right = '<C-l>',
                line_up = '<C-k>',
                line_down = '<C-j>',
            },
        })
        require('mini.splitjoin').setup({
            mappings = {
                toggle = '<leader>J',
            },
        })
        require('mini.align').setup({
            mappings = {
                start = 'ga',
                start_with_preview = 'gp',
            },
        })
    end,
}
