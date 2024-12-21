local neophyte = require('neophyte')
neophyte.setup({
  fonts = {
    {
      name = 'JetBrains Mono NL',
    },
  },
  font_size = {
    kind = 'width', -- 'width' | 'height'
    size = 10,
  },
  -- Multipliers of the base animation speed.
  -- To disable animations, set these to large values like 1000.
  -- cursor_speed = 1,
  -- scroll_speed = 1,
  -- Increase or decrease the distance from the baseline for underlines.
  underline_offset = 1,
})

-- There are also freestanding functions to set these options as desired:
-- Increase font size
vim.keymap.set('n', '<c-+>', function()
  neophyte.set_font_width(neophyte.get_font_width() + 1)
end)

-- Decrease font size
vim.keymap.set('n', '<c-->', function()
  neophyte.set_font_width(neophyte.get_font_width() - 1)
end)

-- Use cmd-ctrl-f to toggle fullsreen on MacOS
-- if this_os:find('Darwin') then
--   vim.keymap.set('n', '<DC-f>', function()
--     neophyte.set_fullscreen(not neophyte.get_fullscreen())
--   end)
-- end

-- Neophyte can also record frames to a PNG sequence.
-- You can convert to a video with ffmpeg:
--
-- ffmpeg -framerate 60 -pattern_type glob -i '/my/frames/location/*.png'
-- -pix_fmt yuv420p -c:v libx264 -vf
-- "colorspace=all=bt709:iprimaries=bt709:itrc=srgb:ispace=bt709:range=tv:irange=pc"
-- -color_range 1 -colorspace 1 -color_primaries 1 -crf 23 -y /my/output/video.mp4
-- neophyte.start_render('/directory/to/output/frames/')
-- neophyte.end_render()
