--[[
    Description
        Meta config for Neovim language servers.
        See lsp/README.md for usage.

    Management
        You can disable a server either by adding its name to the `exclude`
        table below or by setting the server's `disabled` field to `true`.

        Tools can be disabled by excluding them via their meta-config's
        `exclude` table or by setting the tool's `disabled` field to `true`.

    New Config
        To define a new server, create a new config in the lsp/servers
        directory or clone an existing config and edit accordingly.

        Tools for `efm` are defined in lsp/tools.
        See lsp/servers/efm_ls.lua
--]]

local exclude = {}

--------------------------------------------------
-- DO NOT EDIT ANYTHING BELOW THIS LINE ----------
--------------------------------------------------

local fs = require('utils.fs')
local tbl = require('utils.tables')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local formatter = function(name, t)
    if t ~= 'file' then
        return
    end
    return ('lsp.servers.%s'):format(name:gsub('%.lua$', ''))
end

local lib = vim.fn.stdpath('config') .. '/lua/lsp/servers'
for _, path in ipairs(fs.list_dir(lib, '%.lua$', formatter)) do
    if not tbl.find(exclude, path.name) then
        ---@type LspServer
        local server = require(path.name)
        if not server.disabled then
            if type(server.config) == 'function' then
                server.config = server.config(capabilities)
            else
                server.config =
                    ---@diagnostic disable-next-line
                    vim.tbl_extend('force', server.config, capabilities)
            end
            vim.lsp.config(server.name, server.config)
            vim.lsp.enable(server.name)

            -- Call module post-config functions
            for name, fn in pairs(server.post_config) do
                if not vim.tbl_contains(server.exclude, name) then
                    fn()
                end
            end
        end
    end
end
