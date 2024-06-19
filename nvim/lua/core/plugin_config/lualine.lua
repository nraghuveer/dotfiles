require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'mellow',
  },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 1,
      }
    },
    lualine_c = {},
    lualine_x = {"diagnostics"},
    lualine_y = {},
    lualine_z = {},
  }
}
