require('telescope').setup()
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>op', builtin.find_files, {})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
 
