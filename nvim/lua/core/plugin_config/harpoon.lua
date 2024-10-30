require("harpoon").setup({
	global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },

    -- set marks specific to each git branch inside git repository
    mark_branch = true,

    -- enable tabline with harpoon marks
    tabline = false,
    tabline_prefix = "   ",
    tabline_suffix = "   ",
}

})

require("telescope").load_extension('harpoon')

-- keymaps
vim.keymap.set('n', '<leader>ml', ':Telescope harpoon marks<CR>')
vim.keymap.set('n', '<leader>ma', ':lua require("harpoon.mark").add_file()<CR>')
vim.keymap.set('n', '<leader>mn', ':lua require("harpoon.ui").nav_next()<CR>')
vim.keymap.set('n', '<leader>mp', ':lua require("harpoon.ui").nav_prev()<CR>')
vim.keymap.set('n', '<leader>m1', ':lua require("harpoon.term").gotoTerminal(1)<CR>')
vim.keymap.set('n', '<leader>m2', ':lua require("harpoon.term").gotoTerminal(2)<CR>')
vim.keymap.set('n', '<leader>m3', ':lua require("harpoon.term").gotoTerminal(3)<CR>')
vim.keymap.set('n', '<leader>m4', ':lua require("harpoon.term").gotoTerminal(4)<CR>')
vim.keymap.set('n', '<leader>m5', ':lua require("harpoon.term").gotoTerminal(5)<CR>')
