local M = {}

-- should move this to its own module
M._log = function(msg, level, prefix)
    prefix = prefix .. ': ' or ''
    level = level or 'INFO'
    vim.notify(('%q%s'):format(prefix, msg), vim.log.levels[level])
end

---@param binary string Name of binary to search for
---@return string|nil
function M.get_bin_path(binary)
    if vim.fn.executable(binary) == 0 then
        M._log('Binary not found', 'ERROR', binary)
        return nil
    end
    return vim.fn.exepath(binary)
end

---@param path string The directory to search.
---@param pattern string Regex pattern to match against each dir item.
---@param formatter function Takes file name and type; returns string.
---@return table[]
function M.list_dir(path, pattern, formatter)
    pattern = pattern or '.*'
    formatter = formatter or function(name, t)
        return name, t
    end
    local content = {}
    if not path then
        M._log('Invalid or empty path', 'WARN', 'list_dir')
        return content
    end
    local iter = vim.loop.fs_scandir(path)
    while iter do
        local name, t = vim.loop.fs_scandir_next(iter)
        if not name then
            break
        end
        if name:match(pattern) then
            name = formatter(name, t)
            if name then
                table.insert(content, { name = name, type = t })
            end
        end
    end
    return content
end

return M
