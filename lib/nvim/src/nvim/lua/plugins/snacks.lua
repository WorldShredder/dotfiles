--[[
    Description
        This is a meta config for Snacks modules, which brings many QOL
        features to Neovim. For module-specific configurations, refer to the
        sections below.

        See plugins/config/snacks

    Modules
        You can define a snacks module by creating a new config in
        plugins/config/snacks or by cloning and editing an existing config.

        Module Name
            Refers to the file name excluding the `.lua` extension.

        Module Fields
            pre_config      table       Passed to `snacks.setup()`
            post_config     table       Functions to call in `snacks.config()`
            picker_config?  table       Table of settings for a given picker
            keys            table[]     Global mappings for `snacks.keys{}`
            disabled        boolean     Controls the module's state
            exclude         string[]    Members of `post_config` to exclude

    Management
        You can control which modules get activated by adding or removing
        module names to/from the `exclude` table below, or by setting
        `disabled=true` in a module's core table.

    Keymaps
        Mappings defined in module configs.
--]]

local exclude = {}

--------------------------------------------------
-- DO NOT EDIT ANYTHING BELOW THIS LINE ----------
--------------------------------------------------

local fs = require('utils.fs')
local tbl = require('utils.tables')

local snacks = {
    pre_config = {},
    post_config = {},
    post_exclude = {},
}
local keys = {}

local formatter = function(name, t)
    if t ~= 'file' then
        return
    end
    return name:gsub('%.lua$', '')
end

local path = vim.fn.stdpath('config') .. '/lua/plugins/config/snacks'
for _, snack in ipairs(fs.list_dir(path, '%.lua$', formatter)) do
    if not vim.tbl_contains(exclude, snack.name) then
        local data = require('plugins.config.snacks.' .. snack.name)
        if not data.disabled then
            tbl.ext_ipairs(data.keys or {}, keys)
            snacks.pre_config[snack.name] = data.pre_config or {}
            snacks.post_config[snack.name] = data.post_config or {}
            snacks.post_exclude[snack.name] = snack.exclude or {}
        end
    end
end

return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = keys,
    config = function()
        require('snacks').setup(snacks.pre_config)
        for module, post_config in pairs(snacks.post_config) do
            for name, fn in pairs(post_config) do
                local module_excludes = snacks.post_exclude[module]
                if not vim.tbl_contains(module_excludes, name) then
                    fn()
                end
            end
        end
    end,
}
