--[[
    Description
        Provides indentation guides to the UI.

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
--]]

local M = {
    disabled = false,
    exclude = {},
}

-- Snacks.opts.indent{} -------------------------
-------------------------------------------------

M.pre_config = {
    animate = { enabled = false },
}

-- Snacks.config() -------------------------------
--------------------------------------------------

M.post_config = {
    md_off = function()
        vim.g.snacks_indent = true
        vim.api.nvim_create_autocmd('BufRead', {
            pattern = '*.md',
            group = vim.api.nvim_create_augroup(
                'MdIndentOff',
                { clear = true }
            ),
            callback = function()
                Snacks.indent.disable()
                vim.g.snacks_indent = false
            end,
        })
    end,
}

-- Snacks.keys{} --------------------------------
-------------------------------------------------

M.keys = {
    {
        '<leader>I',
        function()
            if vim.g.snacks_indent then
                Snacks.indent.disable()
                vim.g.snacks_indent = false
            else
                Snacks.indent.enable()
                vim.g.snacks_indent = true
            end
        end,
        desc = 'Toggle indentation guide (Snacks.indent)',
        mode = 'n',
    },
}

return M
