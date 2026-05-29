--[[
    Description
        Presents a stylish dashbaord upon boot (minimally configured).

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
        Dashboard
            b       n   Browse files
            r       n   Browse recent files
            g       n   Grep search a file
            q       n   Quit neovim
--]]

local M = {
    disabled = false,
    exclude = {},
}

-- Snacks.opts.dashboard{} ----------------------
-------------------------------------------------

M.pre_config = {
    preset = {
        keys = {
            {
                icon = '󰱼',
                key = 'b',
                desc = 'Browse',
                action = ':lua Snacks.dashboard.pick("files")',
            },
            {
                icon = '󰪹',
                key = 'r',
                desc = 'Recent',
                action = ':lua Snacks.dashboard.pick("oldfiles")',
            },
            {
                icon = '',
                key = 'g',
                desc = 'Grep',
                action = ':lua Snacks.dashboard.pick("live_grep")',
            },
            {
                icon = '󰩈',
                key = 'q',
                desc = 'Quit',
                action = ':q',
            },
        },
        --         header = [[
        -- █ ██ ██ ███
        -- ██ ██ ██
        --  █ █ ██ █ ██]],
        header = [[
   
  █
   █ ██ █ ███
   ██  ██
    █ █ █ ██
  █
 ]],
    },
    sections = {
        { section = 'header' },
        { section = 'keys', padding = 1, gap = 0 },
    },
}

-- Snacks.config() -------------------------------
--------------------------------------------------

M.post_config = {}

-- Snacks.keys{} --------------------------------
-------------------------------------------------

M.keys = {}

return M
