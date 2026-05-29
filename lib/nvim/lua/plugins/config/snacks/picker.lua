--[[
    Description
        provides many telescope-like pickers with git, diagnostics, lsp and
        commandline integration.

    Pre Config
        The table passed to `snacks.setup()` to configure this module.

    Post Config
        A table of functions that are called inside `snacks.config()` after
        requiring the main `snacks` plugins. You can exclude a particular
        post-config function by adding it to the module's `exclude` table.

    Module Fields
        pre_config      table       Passed to `snacks.setup()`
        post_config     table       Functions to call in `snacks.config()`
        keys            table[]     Global mappings for `snacks.keys{}`
        disabled        boolean     Controls the module's state
        exclude         string[]    Members of `post_config` to exclude

    Keymaps
        Global
            Files & Buffers
                tf          n       Search files
                to          n       Search old (recent) files
                tg          n       Grep search
                tb          n       Search buffers
                tr          n       Search registers
            Commandline
                tc          n       Search command history
                tn          n       Search notifications
            Git
                tgf         n       Search git files
                tgl         n       Search git log
                tgs         n       View git status
                tgd         n       View git dif
            Diagnostics
                tdd         n       View diagnostics
                tdb         n       View diagnostics buffer
                tdec        n       Goto declaration
                tdef        n       Goto definition
                tref        n       Goto reference
                timp        n       Goto implementation
                ttyp        n       Goto type definition
                tsym        n       View symbols
        Window
            <C-p>       i, n    Toggle preview
            <C-n>       i, n    Preview scroll down
            <C-u>       i, n    Preview scroll up
            <C-h>       i, n    Toggle hidden files
            <C-s>       i, n    Open in split
            <C-v>       i, n    Open in vertical split
            <C-t>       i, n    Open in new tab
            <ESC>       i, n    Close active picker
        Explorer
            <l>;        n       Open file explorer
            <l><l>      n       Close file explorer
--]]

local M = {
    disabled = false,
    exclude = {},
}

local modules_path = 'plugins.config.snacks'

-- Snacks.opts.picker{} -------------------------
-------------------------------------------------

local function source_explorer()
    local module = require(modules_path .. '.explorer')
    local config = {}
    if not module.disabled then
        config = module.picker_config
    end
    return config
end

M.pre_config = {
    prompt = ' ',
    focus = 'input',
    limit_live = 10000,
    layout = {
        cycle = true,
        preset = function()
            return vim.o.columns >= 120 and 'default' or 'vertical'
        end,
    },
    matcher = {
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
        sort_empty = false,
        filename_bonus = true,
        file_pos = true, -- file:line:col and file:line matching
        frequency = false,
    },
    sort = {
        -- sort priority
        fields = { 'score:desc', '#text', 'idx' },
    },
    ui_select = true, -- snacks for select
    formatters = {
        file = {
            filename_first = false,
            truncate = 'center',
            icon_width = 2,
        },
    },
    previewers = {
        diff = {
            style = 'fancy', -- fancy|syntax|terminal
            -- cmd = { '' },
            wo = {
                breakindent = true,
                wrap = true,
                linebreak = true,
                showbreak = '',
            },
        },
        git = {
            args = {},
        },
    },
    win = {
        input = {
            keys = {
                ['<ESC>'] = { 'close', mode = { 'n', 'i' } },
                ['<C-n>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
                ['<C-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
                ['<C-h>'] = { 'toggle_hidden', mode = { 'i', 'n' } },
                ['<C-p>'] = { 'toggle_preview', mode = { 'i', 'n' } },
            },
        },
    },
    sources = {
        explorer = source_explorer(),
    },
}

-- Snacks.config() -------------------------------
--------------------------------------------------

M.post_config = {}

-- Snacks.key{} ---------------------------------
-------------------------------------------------

M.keys = {
    -- Files & Buffers
    {
        'tf',
        function()
            Snacks.picker.files()
        end,
        desc = 'Search files (Picker)',
        mode = 'n',
    },
    {
        'to',
        function()
            Snacks.picker.recent()
        end,
        desc = 'Search recent files (Picker)',
        mode = 'n',
    },
    {
        'tg',
        function()
            Snacks.picker.grep()
        end,
        desc = 'Grep search (Picker)',
        mode = 'n',
    },
    {
        'tb',
        function()
            Snacks.picker.buffers()
        end,
        desc = 'Search buffers (Picker)',
        mode = 'n',
    },
    {
        'tr',
        function()
            Snacks.picker.registers()
        end,
        desc = 'Search registers (Picker)',
        mode = 'n',
    },
    -- Commandline
    {
        'tc',
        function()
            Snacks.picker.command_history()
        end,
        desc = 'Search command history (Picker)',
        mode = 'n',
    },
    {
        'tn',
        function()
            Snacks.picker.notifications()
        end,
        desc = 'Search notifs (Picker)',
        mode = 'n',
    },
    -- Git
    {
        'tgf',
        function()
            Snacks.picker.git_files()
        end,
        desc = 'Search git files (Picker)',
        mode = 'n',
    },
    {
        'tgl',
        function()
            Snacks.picker.git_log()
        end,
        desc = 'Search git logs (Picker)',
        mode = 'n',
    },
    {
        'tgl',
        function()
            Snacks.picker.git_log()
        end,
        desc = 'Search git logs (Picker)',
        mode = 'n',
    },
    {
        'tgs',
        function()
            Snacks.picker.git_status()
        end,
        desc = 'View git status (Picker)',
        mode = 'n',
    },
    {
        'tgd',
        function()
            Snacks.picker.git_diff()
        end,
        desc = 'View git diff (Picker)',
        mode = 'n',
    },
    -- Diagnostics
    {
        'tdd',
        function()
            Snacks.picker.diagnostics()
        end,
        desc = 'View diagnostics (Picker)',
        mode = 'n',
    },
    {
        'tdb',
        function()
            Snacks.picker.diagnostics_buffer()
        end,
        desc = 'View diagnostics buffer (Picker)',
        mode = 'n',
    },
    {
        'tdec',
        function()
            Snacks.picker.lsp_declarations()
        end,
        desc = 'Goto declaration (Picker)',
        mode = 'n',
    },
    {
        'tdef',
        function()
            Snacks.picker.lsp_definitions({
                auto_confirm = false,
            })
        end,
        desc = 'Goto definition (Picker)',
        mode = 'n',
    },
    {
        'tref',
        function()
            Snacks.picker.lsp_references({
                auto_confirm = false,
            })
        end,
        nowait = true,
        desc = 'View references (Picker)',
        mode = 'n',
    },
    {
        'timp',
        function()
            Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto implementation (Picker)',
        mode = 'n',
    },
    {
        'ttyp',
        function()
            Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto type definition (Picker)',
        mode = 'n',
    },
    {
        'tsym',
        function()
            Snacks.picker.lsp_symbols()
        end,
        desc = 'View symbols (Picker)',
        mode = 'n',
    },
    -- Explorer
    {
        '<leader>;',
        function()
            Snacks.picker.explorer()
        end,
        desc = 'Explore files (Picker)',
        mode = 'n',
    },
    {
        '<leader><leader>',
        function()
            -- Close explorer with double-leader exit
            local picker = Snacks.picker.get({ source = 'explorer' })
            if picker and picker[1] and picker[1]:on_current_tab() then
                picker[1]:close()
            end
        end,
        desc = 'Close explore (Picker)',
        mode = 'n',
    },
}

return M
