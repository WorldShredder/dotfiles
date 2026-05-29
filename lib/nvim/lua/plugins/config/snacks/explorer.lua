--[[
    Description
        Provides a file explorer in the side panel. This plugin is technically
        a picker and is compatible with general pick mappings; see picker.lua.

    Pre Config
        The table passed to `snacks.setup()` to configure this module.

    Post Config
        A table of functions that are called inside `snacks.config()` after
        requiring the main `snacks` plugins. You can exclude a particular
        post-config function by adding it to the module's `exclude` table.

    Picker Config
        The table passed to the picker module to configure this picker.

    Module Fields
        pre_config      table       Passed to `snacks.setup()`
        post_config     table       Functions to call in `snacks.config()`
        keys            table[]     Global mappings for `snacks.keys{}`
        disabled        boolean     Controls the module's state
        exclude         string[]    Members of `post_config` to exclude

    Keymaps
        Explorer
            l           n   Confirm
            a           n   Add file/directory
            d           n   Delete file/directory
            r           n   Rename file/directory
            c           n   Copy file/directory
            m           n   Move file/directory
            o           n   Open file/directory with xdg-open
            P           n   Toggle preview
            y           n   Yank file/directory path
            p           n   Paste clipboard
            <L>/        n   Grep search explorer
            h           n   Collapse node
            Z           n   Collapse all nodes
            H           n   Show hidden files
--]]

local M = {
    disabled = false,
    exclude = {},
}

-- Snacks.opts.explorer{} -----------------------
-------------------------------------------------

M.pre_config = {}

-- Snacks.config() -------------------------------
--------------------------------------------------

M.post_config = {}

-- Snacks.opts.picker.sources.explorer{} ---------
--------------------------------------------------

M.picker_config = {
    finder = 'explorer',
    sort = { fields = { 'sort' } },
    supports_live = true,
    tree = true,
    watch = true,
    diagnostics = true,
    diagnostics_open = false,
    git_status = true,
    git_status_open = false,
    git_untracked = true,
    follow_file = true,
    focus = 'list',
    auto_close = false,
    jump = { close = false },
    layout = { preset = 'sidebar', preview = false, layout = { width = 25 } },
    formatters = {
        file = { filename_only = true },
        severity = { pos = 'right' },
    },
    matcher = { sort_empty = false, fuzzy = false },
    config = function(opts)
        return require('snacks.picker.source.explorer').setup(opts)
    end,
    win = {
        list = {
            keys = {
                ['<BS>'] = 'explorer_up',
                ['l'] = 'confirm',
                ['h'] = 'explorer_close', -- close directory
                ['a'] = 'explorer_add',
                ['d'] = 'explorer_del',
                ['r'] = 'explorer_rename',
                ['c'] = 'explorer_copy',
                ['m'] = 'explorer_move',
                ['o'] = 'explorer_open', -- open with system application
                ['P'] = 'toggle_preview',
                ['y'] = { 'explorer_yank', mode = { 'n', 'x' } },
                ['p'] = 'explorer_paste',
                ['u'] = 'explorer_update',
                ['<c-c>'] = 'tcd',
                ['<leader>/'] = 'picker_grep',
                ['O'] = 'tab',
                ['.'] = 'explorer_focus',
                ['I'] = 'toggle_ignored',
                ['H'] = 'toggle_hidden',
                ['Z'] = 'explorer_close_all',
                [']g'] = 'explorer_git_next',
                ['[g'] = 'explorer_git_prev',
                [']d'] = 'explorer_diagnostic_next',
                ['[d'] = 'explorer_diagnostic_prev',
                [']w'] = 'explorer_warn_next',
                ['[w'] = 'explorer_warn_prev',
                [']e'] = 'explorer_error_next',
                ['[e'] = 'explorer_error_prev',
            },
        },
    },
}

-- Snacks.keys{} --------------------------------
-------------------------------------------------

M.keys = {}

return M
