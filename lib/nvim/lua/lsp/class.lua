---@class LspServer
---@field name string -- The name of the LSP server
---@field config table<string, any>|fun(capabilities: table): table<string, any> --
--- Table or function output passed to vim.lsp.config()
---@field post_config table<string, function> -- Functions to call after
--- vim.lsp.config()
---@field exclude string[] -- Post config functions to exclude
---@field meta_exclude string[] -- LSP servers to exclude if this is a meta config
--- object
---@field disabled boolean -- Whether or not to disable this LSP server
local LspServer = {
    config = {},
    post_config = {},
    exclude = {},
    meta_exclude = {},
    disabled = false,
}

---Create new LspServer config object
---@param name string -- The name of the LSP server
---@return LspServer
function LspServer:new(name)
    return setmetatable({ name = name }, { __index = self })
end

---@class LspTool
---@field name string -- The name of the LSP tool, e.g., 'luacheck'
---@field lang string[] -- Table of associated languages for this tool
---@field config table<string, any>|fun(): table<string, any> -- Table or function
--- output added to EFM's `languages` table
---@field post_config table<string, function> -- Functions to be added to the
--- meta-config that is including this tool
---@field exclude string[] -- Post config functions to exclude
---@field disabled boolean -- Whether or not to disable this LSP tool
local LspTool = {
    lang = {},
    config = {},
    post_config = {},
    exclude = {},
    disabled = false,
}

---Create new LspTool config object
---@param name string -- The name of the LSP tool, e.g., 'luacheck'
---@return LspTool
function LspTool:new(name)
    return setmetatable({ name = name }, { __index = self })
end

return {
    LspServer = LspServer,
    LspTool = LspTool,
}
