require('telescope').setup()
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>op', builtin.find_files, {})
vim.keymap.set('n', '<leader>gr', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require("telescope").load_extension("git_worktree")
vim.keymap.set('n', '<leader>wtl', function()
  require('telescope').extensions.git_worktree.git_worktrees()
end)

vim.keymap.set('n', '<leader>wtc', function()
  require('telescope').extensions.git_worktree.create_git_worktree()
end)
