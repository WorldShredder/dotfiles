--[[
    Description
        Provides methods for operating on git files at the hunk level.

    Keymaps
        Global
            <L>hf       n       Next hunk
            <L>hb       n       Previous hunk
            <L>hd       n       View diff of current hunk and HEAD
            <L>h[1-20]  n       View diff of current hunk and HEAD~n
            <L>hs       n       Stage hunk under cursor
            <L>hS       n       Stage current buffer
            <L>hr       n       Reset hunk under cursor
            <L>hR       n       Reset current buffer
            <L>hp       n       Preview hunk under cursor
            <L>hi       n       Inline preview hunk under cursor
            <L>hg       n,o,x   Select hunk as a text object
--]]

return {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {
        on_attach = function(bufnr)
            local gs = require('gitsigns')

            local function map(mode, key, action, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, key, action, opts)
            end

            ---- NAVIGATION ---------------------
            -------------------------------------

            -- Hunk Forward
            map('n', '<leader>hf', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '<leader>hf', bang = true })
                else
                    gs.nav_hunk('next')
                end
            end)

            -- Hunk Backward
            map('n', '<leader>hb', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '<leader>hb', bang = true })
                else
                    gs.nav_hunk('prev')
                end
            end)

            ---- ACTIONS ------------------------
            -------------------------------------

            -- Hunk Diff
            map('n', '<leader>hd', gs.diffthis)

            -- Hunk Diff by Reverse Index (HEAD~1 to HEAD~20)
            for i = 1, 20 do
                -- map('n', ('<leader>h%id'):format(i), function()
                map('n', '<leader>h' .. tostring(i), function()
                    gs.diffthis(('~%i'):format(i))
                end)
            end

            -- Hunk Stage
            map('n', '<leader>hs', gs.stage_hunk)

            -- Hunk Reset
            map('n', '<leader>hr', gs.reset_hunk)

            -- Hunk Stage Buffer
            map('n', '<leader>hS', gs.stage_buffer)

            -- Hunk Reset Buffer
            map('n', '<leader>hR', gs.reset_buffer)

            -- Hunk Preview
            map('n', '<leader>hp', gs.preview_hunk)

            -- Hunk Inline Preview
            map('n', '<leader>hi', gs.preview_hunk_inline)

            -- Hunk Grab as Text Object
            map({ 'n', 'o', 'x' }, '<leader>hg', gs.select_hunk)
        end,
    },
}
