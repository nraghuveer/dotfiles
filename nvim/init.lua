-- Minimal, plugin-free Neovim config.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic editor defaults
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.updatetime = 300

-- <leader> is Space; jj exits insert mode.
vim.keymap.set("i", "jj", "<Esc>", { silent = true, desc = "Exit insert mode" })

-- Diagnostics and LSP keymaps.
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("VanillaLspKeys", { clear = true }),
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostic" }))
  end,
})

local function project_root(bufnr)
  return vim.fs.root(bufnr or 0, { ".git", "go.work", "go.mod", "Cargo.toml", "rust-project.json" }) or vim.uv.cwd()
end

local lsp_servers = {
  rust = {
    name = "rust-analyzer",
    cmd = { "rust-analyzer" },
    root_markers = { "Cargo.toml", "rust-project.json", ".git" },
    settings = {
      ["rust-analyzer"] = {
        check = { command = "clippy" },
      },
    },
  },
  go = {
    name = "gopls",
    cmd = { "gopls" },
    root_markers = { "go.work", "go.mod", ".git" },
  },
}

local function start_lsp(args, server)
  if vim.fn.executable(server.cmd[1]) ~= 1 then
    vim.notify(
      string.format("%s is not installed; LSP will not start", server.cmd[1]),
      vim.log.levels.WARN
    )
    return
  end

  vim.lsp.start({
    name = server.name,
    cmd = server.cmd,
    root_dir = vim.fs.root(args.buf, server.root_markers) or vim.uv.cwd(),
    settings = server.settings,
  }, { bufnr = args.buf })
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("VanillaLsp", { clear = true }),
  pattern = "rust",
  callback = function(args)
    start_lsp(args, lsp_servers.rust)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("VanillaGoLsp", { clear = true }),
  pattern = { "go", "gomod", "gowork", "gosum", "gotmpl" },
  callback = function(args)
    start_lsp(args, lsp_servers.go)
  end,
})

-- Tiny fzf helpers. They use the external fzf binary and avoid a plugin manager.
local function open_fzf(command, on_select)
  if vim.fn.executable("fzf") ~= 1 then
    vim.notify("fzf is not installed", vim.log.levels.ERROR)
    return
  end

  local tmp = vim.fn.tempname()
  local cwd = project_root(0)
  local full_command = command .. " > " .. vim.fn.shellescape(tmp)

  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.75)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    width = width,
    height = height,
    row = row,
    col = col,
  })

  vim.fn.termopen(full_command, {
    cwd = cwd,
    on_exit = function()
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end

        local selection = ""
        if vim.fn.filereadable(tmp) == 1 then
          selection = table.concat(vim.fn.readfile(tmp), "\n")
          vim.fn.delete(tmp)
        end

        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end

        if selection ~= "" then
          on_select(selection, cwd)
        end
      end)
    end,
  })

  vim.cmd.startinsert()
end

local function file_source_command()
  if vim.fn.executable("fff") == 1 then
    return "fff"
  end

  if vim.fn.executable("fd") == 1 then
    return "fd --type f --hidden --follow --exclude .git"
  end

  if vim.fn.executable("fdfind") == 1 then
    return "fdfind --type f --hidden --follow --exclude .git"
  end

  return "find . -type f -not -path '*/.git/*' | sed 's#^./##'"
end

local function absolute_path(cwd, file)
  if file:sub(1, 1) == "/" then
    return file
  end
  return cwd .. "/" .. file
end

local function fzf_files()
  open_fzf(file_source_command() .. " | fzf --prompt 'Files> '", function(selection, cwd)
    local file = vim.split(selection, "\n", { plain = true })[1]
    if file and file ~= "" then
      vim.cmd.edit(vim.fn.fnameescape(absolute_path(cwd, file)))
    end
  end)
end

local function fzf_grep()
  if vim.fn.executable("rg") ~= 1 then
    vim.notify("ripgrep (rg) is not installed", vim.log.levels.ERROR)
    return
  end

  open_fzf(
    "fzf --disabled --prompt 'Rg> ' "
      .. "--bind "
      .. vim.fn.shellescape("change:reload:rg --column --line-number --no-heading --color=never --smart-case {q} || true"),
    function(selection, cwd)
      local line = vim.split(selection, "\n", { plain = true })[1]
      local file, lnum, col = line:match("^(.-):(%d+):(%d+):")
      if file then
        vim.cmd.edit(vim.fn.fnameescape(absolute_path(cwd, file)))
        vim.api.nvim_win_set_cursor(0, { tonumber(lnum), tonumber(col) - 1 })
        vim.cmd.normal({ "zz", bang = true })
      end
    end
  )
end

vim.keymap.set("n", "<leader>ff", fzf_files, { silent = true, desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf_grep, { silent = true, desc = "Live grep" })
