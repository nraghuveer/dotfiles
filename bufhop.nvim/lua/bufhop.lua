local M = {}
M.buffers = {}
M.sorted_buffers = {}
local events_buf = nil


-- TODO
-- Crop until the project name for shrot name
-- fix the line numbers on buffers
-- dynamic bindings - vimium kinda

local function get_short_name(fullpath)
  if fullpath == '' or not fullpath:find('/') then
    return fullpath
  end
  local parts = {}
  for part in fullpath:gmatch("[^/]+") do
    table.insert(parts, part)
  end
  if #parts == 1 then
    return parts[1]
  end
  local result = {}
  for i = 1, #parts - 1 do
    table.insert(result, parts[i]:sub(1, 1))
  end
  table.insert(result, parts[#parts])
  -- return table.concat(result, '/')
  return parts[#parts]
end

local augroup = vim.api.nvim_create_augroup("Scartch", { clear = true })

local function set_cur_buffer(idx)
  local bufname = M.sorted_buffers[idx]
  table.remove(M.sorted_buffers, idx)
  table.insert(M.sorted_buffers, 1, bufname)
  return M.buffers[bufname]
end

local function switch_to_buffer_by_index(index)
  if not events_buf or not vim.api.nvim_buf_is_valid(events_buf) then
    return
  end

  local bufnames = M.sorted_buffers
  if not bufnames or index > #bufnames then
    return
  end

  local buf_entry = set_cur_buffer(index)
  if buf_entry and buf_entry.bufname ~= '' then
    vim.cmd('edit ' .. buf_entry.bufname)
    vim.api.nvim_win_set_cursor(0, buf_entry.pos)
  end
end

local function update_events_buffer()
  -- Check if events buffer exists and is valid
  if events_buf and vim.api.nvim_buf_is_valid(events_buf) then
    local lines = {}
    for _, buffer in ipairs(M.sorted_buffers) do
      local entry = M.buffers[buffer]
      table.insert(lines, entry.bufname_short)
    end
    -- Update buffer content
    vim.api.nvim_buf_set_option(events_buf, 'modifiable', true)
    vim.api.nvim_buf_set_lines(events_buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(events_buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(events_buf, 'relativenumber', false)
    vim.api.nvim_buf_set_option(events_buf, 'nu', true)
  end
end

local function record_buffer(event_type, bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname == "" then
    return
  end

  local cur_pos = vim.api.nvim_win_get_cursor(0)
  M.buffers[bufname] = {
    bufnr = bufnr,
    bufname = bufname,
    bufname_short = get_short_name(bufname),
    pos = cur_pos
  }

  if event_type == "enter" then
    -- find the index in the sorted index
    local index = {}
    for k, v in pairs(M.sorted_buffers) do
      index[v] = k
    end
    if index[bufname] ~= nil then
      table.remove(M.sorted_buffers, index[bufname])
    end
    table.insert(M.sorted_buffers, 1, bufname)
  end

  update_events_buffer()
end

local function show_buffers()
  -- If buffer exists and is visible, just return
  if events_buf and vim.api.nvim_buf_is_valid(events_buf) then
    local wins = vim.fn.win_findbuf(events_buf)
    if #wins > 0 then
      return
    end
  end

  events_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(events_buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(events_buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(events_buf, 'modifiable', false)

  update_events_buffer()

  -- Open the buffer in a new window
  vim.cmd('botright vertical split')
  vim.cmd('vertical resize 50') -- Adjust width as needed
  vim.api.nvim_win_set_buf(0, events_buf)
  for i = 1, 9 do
    vim.keymap.set('n', string.format('hh%d', i), function()
      switch_to_buffer_by_index(i)
    end)
  end

  -- Set buffer local mappings
  vim.api.nvim_buf_set_keymap(events_buf, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
end

local function setup()
  vim.api.nvim_create_user_command('Bufhop', show_buffers, {})
  vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    desc = "Record buffer enter",
    callback = function(args)
      record_buffer("enter", args.buf)
    end
  })
  vim.api.nvim_create_autocmd("BufLeave", {
    group = augroup,
    desc = "Record buffer leave",
    callback = function(args)
      record_buffer("leave", args.buf)
    end
  })
end

return { setup = setup }
