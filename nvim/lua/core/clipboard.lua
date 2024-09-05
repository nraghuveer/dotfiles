-- Define the function to sync clipboard contents
local function sync_clipboard()
  local clipboard_contents = vim.fn.getreg('"')  -- Get the contents of the default register
  local ssh_connection = os.getenv("SSH_CONNECTION")
  local clipboard_sync_command

  if ssh_connection then
    local ssh_host = string.match(ssh_connection, "%S+")
    clipboard_sync_command = string.format("ssh %s '(pbcopy || xsel -i) 2>/dev/null'", ssh_host)
  else
    clipboard_sync_command = "(pbcopy || xsel -i) 2>/dev/null"
  end

  vim.fn.system(clipboard_sync_command, clipboard_contents)
end

-- Map the function to F3 key
vim.api.nvim_set_keymap('n', '<F3>', '<cmd>lua sync_clipboard()<CR>', {noremap = true, silent = true})
