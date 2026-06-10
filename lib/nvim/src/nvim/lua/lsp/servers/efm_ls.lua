--[[
    Description
        Meta config for general purpose language server (efm) config for LSP tools.
        See lsp/README.md for usage.
--]]

local M = require('lsp.class').LspServer:new('efm')

M.post_config = {
    -- Format code of current file on save
    format_on_save = function()
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('FormatOnSaveGroup', {}),
            callback = function(args)
                local clients = vim.lsp.get_clients({ name = 'efm', bufnr = args.buf })
                if vim.tbl_isempty(clients) then
                    return
                end
                -- set async to true if you don't mind saving twice
                vim.lsp.buf.format({ name = 'efm', async = false })
            end,
        })
    end,
}

--------------------------------------------------
-- DO NOT EDIT ANYTHING BELOW THIS LINE ----------
--------------------------------------------------

local fs = require('utils.fs')

---@enum lsp_tool
local lsp_tool = { linter = 'linters', formatter = 'formatters' }
local lsp_home = vim.fn.stdpath('config') .. '/lua/lsp'

---@param tool_type lsp_tool LSP tool type, e.g., linter or formatter
---@return table[] modules LSP tool config tables
local function _get_modules(tool_type)
    local formatter = function(name, t)
        if t ~= 'file' then
            return
        end
        return ('lsp.tools.%s.%s'):format(tool_type, name:gsub('%.lua$', ''))
    end
    local path = lsp_home .. '/tools/' .. tool_type
    local modules = {}
    for _, module in ipairs(fs.list_dir(path, '%.lua$', formatter)) do
        table.insert(modules, require(module.name))
    end
    return modules
end

M.config = function(capabilities)
    local tools = {
        linters = _get_modules(lsp_tool.linter),
        formatters = _get_modules(lsp_tool.formatter),
    }
    local languages = {}
    local filetypes = {}
    for _, tool_type in pairs(tools) do
        for _, tool in ipairs(tool_type) do
            for _, lang in ipairs(tool.lang) do
                if
                    not vim.tbl_contains(M.meta_exclude, tool.name)
                    and not tool.disabled
                then
                    if not vim.tbl_contains(filetypes, lang) then
                        table.insert(filetypes, lang)
                        languages[lang] = {}
                    end
                    table.insert(languages[lang], tool.config)
                end
            end
            -- Merge tool post_config with server post_config
            for name, fn in pairs(tool.post_config) do
                if not vim.tbl_contains(tool.exclude, name) then
                    if M.post_config[name] then
                        vim.notify(
                            ('Post Config Conflict: %q in %q and %q'):format(
                                name,
                                M.name,
                                tool.name
                            ),
                            vim.log.levels.WARN
                        )
                    else
                        M.post_config[name] = fn
                    end
                end
            end
        end
    end
    local config = {
        capabilities = capabilities or {},
        settings = {
            languages = languages,
        },
        filetypes = filetypes,
        init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
            hover = true,
            documentSymbol = true,
            codeAction = true,
            completion = true,
        },
    }
    return config
end

return M
