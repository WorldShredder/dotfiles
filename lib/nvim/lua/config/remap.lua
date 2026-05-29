vim.g.mapleader = ','
vim.g.maplocalleader = ','

---- MODE SWITCHING ------------------------------
--------------------------------------------------

vim.keymap.set('i', '<leader><leader>', '<ESC>l')
vim.keymap.set('v', '<leader><leader>', '<ESC>')
vim.keymap.set('s', '<leader><leader>', '<ESC>')

---- FILE MANAGEMENT -----------------------------
--------------------------------------------------

vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>Q', ':q!<CR>')
vim.keymap.set('n', '<leader>s', ':w<CR>')
vim.keymap.set('n', '<leader>S', ':wq<CR>')
vim.keymap.set('n', '<leader>ep', vim.cmd.Ex)

---- TAB CONTROL ---------------------------------
--------------------------------------------------

vim.keymap.set('n', '<leader>tn', ':tab new<CR>')
vim.keymap.set('n', '<leader>tc', ':tab close<CR>')
vim.keymap.set('n', '>', ':tabnext<CR>')
vim.keymap.set('n', '<', ':tabprevious<CR>')

---- YANK/PASTE SYSTEM CLIPBOARD -----------------
--------------------------------------------------

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')

---- TEXT/BLOCK NAVIGATION -----------------------
--------------------------------------------------

-- Swapped `{` and `}` to mimic `j` and `k` pos
vim.keymap.set({ 'n', 'v' }, '{', '}')
vim.keymap.set({ 'n', 'v' }, '}', '{')
-- `t` is dedicated to telescope/picker
vim.keymap.set({ 'n', 'v' }, 'gt', 't')

---- SELECT ALL MAPPING --------------------------
--------------------------------------------------
-- Select all file content and return to a given
-- mark upon exiting visual mode. Default mark: z
--------------------------------------------------

vim.keymap.set('n', '<leader>a', function()
    local mark = 'z'
    vim.g.select_all_mark = mark
    vim.cmd([[normal! m]] .. mark .. [[ggVG]])
end)

vim.api.nvim_create_autocmd('ModeChanged', {
    ---@diagnostic disable-next-line: undefined-global
    group = augroup,
    pattern = '[vV\x16]*:*',
    callback = function()
        if vim.g.select_all_mark ~= nil then
            vim.cmd([[silent! normal! ']] .. vim.g.select_all_mark)
            vim.g.select_all_mark = nil
        end
    end,
})
