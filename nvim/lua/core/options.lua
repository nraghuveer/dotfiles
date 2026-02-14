vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd [[ set noswapfile ]]

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- render
vim.opt.list = false

vim.opt.modifiable = true

-- Background image with opacity
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.opt.termguicolors = true

-- Set background image
vim.cmd([[
  augroup BackgroundImage
    autocmd!
    autocmd VimEnter * call system('osascript -e "tell application \"Terminal\" to set background image of front window to POSIX file \"/Users/raghuveernaraharisetti/Documents/wallpapers/siva.jpeg\""')
  augroup END
]])

