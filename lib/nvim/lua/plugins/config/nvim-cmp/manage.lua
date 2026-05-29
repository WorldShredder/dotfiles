local M = {}

local tbl = require('utils.tables')

---@param name string
M.add_source = function(name, icon)
    local cmp_config = require('cmp.config')
    local cmp_sources = cmp_config.get().sources
    local has_source = false
    for _, src in ipairs(cmp_sources) do
        if src.name == name then
            has_source = true
            break
        end
    end
    if has_source == false then
        cmp_config.set_global({
            sources = tbl.ext_ipairs({ { name = name } }, cmp_sources),
        })
        M.add_menu_item(name, icon)
    end
end

---@param name string
---@param icon string
M.add_menu_item = function(name, icon)
    if type(icon) ~= 'string' then
        return
    end
    local menu_item = {}
    menu_item[name] = icon
    vim.g.nvim_cmp_global_menu =
        tbl.ext_pairs(menu_item, vim.g.nvim_cmp_global_menu)
end

return M
