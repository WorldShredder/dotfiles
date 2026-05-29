-- luacheck: globals vim

local M = {}

M.format_cmd = function(binary, ...)
    local args = { ... }
    if not binary then
        return ''
    end
    return ('%s %s -'):format(binary, table.concat(args, ' '))
end

M.format_file_cmd = function(binary, ...)
    local args = { ... }
    return ('%s %s'):format(binary, table.concat(args, ' '))
end

return M
