vim.opt.termguicolors = true
vim.opt.background = "dark"
-- vim.cmd('colorscheme github_dark_dimmed')
-- vim.cmd('colorscheme kanagawa-wave')
-- vim.cmd('colorscheme vague')
-- vim.cmd('colorscheme oldworld')
-- vim.cmd('colorscheme rusticated')
-- vim.cmd('colorscheme intellij')
vim.cmd('colorscheme vscode')
--
require("themery").setup({
  themes = { "kanagawa-wave", "kanagawa-dragon", "oldworld", "vague", "rose-pine", "catppuccin", "intellij", "rusticated", "vscode", "fleet" },
  livePreview = true,
})

require("catppuccin").setup({
  integrations = {
    cmp = true,
    gitsigns = true,
    treesitter = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
  }
})


require("vague").setup({
  transparent = false, -- don't set background
  style = {
    -- "none" is the same thing as default. But "italic" and "bold" are also valid options
    comments = "italic",
    conditionals = "none",
    functions = "none",
    keywords = "none",
    headings = "bold", -- markdown headings
    operators = "none",
    keyword_return = "none",
    strings = "italic",
    variables = "none",
  },
  -- These are the default colors, but they are overideable.
  -- Different highlights which may be non related share some colors, so expirement.
  colors = {
    bg = "#18191a",
    fg = "#cdcdcd",
    floatBorder = "#878787",
    line = "#282830",
    comment = "#646477",
    builtin = "#bad1ce",
    func = "#be8c8c",
    string = "#d7b797",
    number = "#d2a374",
    property = "#b4b4ce",
    constant = "#b4b4ce",
    parameter = "#b9a3ba",
    visual = "#363738",
    error = "#d2788c",
    warning = "#e6be8c",
    hint = "#8ca0dc",
    operator = "#96a3b2",
    keyword = "#7894ab",
    type = "#a1b3b9",
    search = "#465362",
    -- used mostly in git related highlights
    plus = "#8faf77",
    delta = "#e6be8c",
  }
})
