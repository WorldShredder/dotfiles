--[[
    Description
        Provides a better looking vim.ui.input, just like LazyVim ;)

    Commandline
        This configuration maps `:` to Snacks.input() as a commandline
        replacement. In this mode, suggestions and standard command history
        are not available. If the subsequent key is `:`, the prompt will
        switch to the standard commandline. Works in normal and visual modes.

        Warning: This method is experimental and does not use Snacks.input()
            as it was intended to be used.

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
            :       n,v     Open input as commandline
--]]

local M = {
    disabled = false,
    exclude = {},
}

-- Snacks.opts.input{} --------------------------
-------------------------------------------------

M.pre_config = {
    relative = 'editor',
    noautocmd = true,
    bo = {
        filetype = 'snacks_input',
        buftype = 'prompt',
    },
}

-- Snacks.config() -------------------------------
--------------------------------------------------

M.post_config = {}

-- Snacks.keys{} --------------------------------
-------------------------------------------------

--- Replaces commandline with Snacks.input().
--- Press `:` again to deploy standard commandline.
local cmd_fallback = function()
    local mode = vim.api.nvim_get_mode().mode or 'n'
    local default = ''
    if mode:lower() == 'v' then
        default = "'<,'>"
    end
    local id
    local snacks = require('snacks')
    local state = snacks.input(
        { prompt = 'Command ' .. '(' .. mode .. ')', default = default },
        function(value)
            vim.cmd(value or '')
            -- kill key listener when input exits normally
            vim.on_key(nil, id)
        end
    )

    local function fetch_input(bufnr)
        if bufnr then
            local ln = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
            if ln and #ln > 0 and #ln[1] > 0 then
                return ln[1], ln[1]:sub(0, 1)
            end
        end
    end

    local function runner()
        local bufnr = state.buf
        local ln, c = fetch_input(bufnr)
        if c and (c == ':' or ln:match("'<,'>:")) then
            -- kill key listener when input is force closed
            vim.on_key(nil, id)
            state:close()
            local keys = ':'
            if mode:lower() == 'v' then
                keys = keys .. "'<,'>"
            end
            keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
            vim.api.nvim_feedkeys(keys, 'n', true)
        end
    end

    id = vim.on_key(function(key)
        -- kill key listener and input on empty backspace
        if key == string.char(0x80) .. 'kb' then
            local ln, _ = fetch_input(state.buf)
            if not ln or ln == '' then
                vim.on_key(nil, id)
                state:close()
            end
        end
        vim.schedule(runner)
    end)
end

M.keys = {
    {
        ':',
        cmd_fallback,
        desc = 'Run command (Snacks.Input)',
        mode = { 'n', 'v' },
    },
}

return M
