require('telescope').setup()
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>op', builtin.find_files, {})
vim.keymap.set('n', '<leader>gr', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ob', function()
  require('telescope.builtin').buffers({
    sort_mru = true,
    ignore_current_buffer = true,
    show_all_buffers = false
  })
end)
