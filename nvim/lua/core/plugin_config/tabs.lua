require('barbar').setup{}

local map = vim.api.nvim_set_keymap
local ops = { noremap = true, silent = true }

map('n', '<C-b>', '<Cmd>BufferPrevious<CR>', ops)
map('n', '<C-n>', '<Cmd>BufferNext<CR>', ops)
map('n', '<C-x>', '<Cmd>BufferClose<CR>', ops)
map('n', '<C-p>', '<Cmd>BufferPin<CR>', ops)
map('n', '<leader>cbr', '<Cmd>BufferCloseBuffersRight<CR>', ops)
map('n', '<leader>cbl', '<Cmd>BufferCloseBuffersLeft<CR>', ops)
map('n', '<leader>cbc', '<Cmd>BufferCloseAllButCurrent<CR>', ops)
map('n', '<A-n>', '<Cmd>BufferMovePrevious<CR>', ops)
map('n', '<A-m>', '<Cmd>BufferMoveNext<CR>', ops)
