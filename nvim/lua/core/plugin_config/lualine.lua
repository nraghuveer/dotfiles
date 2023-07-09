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
    }
  }
}
