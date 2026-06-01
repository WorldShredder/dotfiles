local M = {}

---@param src table
---@param dest table
M.ext_pairs = function(src, dest)
    src = src or {}
    dest = dest or {}
    for k, v in pairs(src) do
        dest[k] = v
    end
    return dest
end

---@param src table
---@param dest table
M.ext_ipairs = function(src, dest)
    src = src or {}
    dest = dest or {}
    for _, v in ipairs(src) do
        table.insert(dest, v)
    end
    return dest
end

---@param array table
---@param element any
M.find = function(array, element)
    for _, v in ipairs(array) do
        if v == element then
            return true
        end
    end
    return false
end

return M
