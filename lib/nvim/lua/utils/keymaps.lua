local M = {}

M.map = function(mode, lhs, rhs, opts)
    mode = mode or 'n'
    opts = opts or {}
    vim.keymap.set(mode, lhs, rhs, opts)
end

return M
