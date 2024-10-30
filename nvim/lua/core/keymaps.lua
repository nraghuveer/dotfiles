-- Navigate vim panes better
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>')
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>')
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>')
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>')

vim.api.nvim_set_keymap('n', '<leader>ve', ':Explore<CR>', { noremap = true, silent = true })

