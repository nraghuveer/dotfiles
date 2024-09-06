require('telescope').setup()
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>op', builtin.find_files, {})
vim.keymap.set('n', '<leader>gr', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

