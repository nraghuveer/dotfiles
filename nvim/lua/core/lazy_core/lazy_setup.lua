-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  { "github/copilot.vim" },
  { -- color schemes
    "vague2k/vague.nvim",
    "d00h/nvim-rusticated",
    "chiendo97/intellij.vim",
    "rebelot/kanagawa.nvim",
    "dgox16/oldworld.nvim",
    "zaldih/themery.nvim",
    { "rose-pine/neovim", name = "rose-pine" },
    { "catppuccin/nvim",  name = "catppuccin", priority = 1000 },
    "Mofiqul/vscode.nvim",
    "felipeagc/fleet-theme-nvim",
  },
  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    }
  },
  {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = false, -- if you want to enable the plugin
      message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
      date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },
  },
  { "natecraddock/sessions.nvim" },
  -- {
  -- "Shatur/neovim-session-manage",
  -- dependencies = { 'nvim-lua/plenary.nvim' },
  -- },
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "ThePrimeagen/harpoon",
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  {
    "L3MON4D3/LuaSnip",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "nvimdev/lspsaga.nvim",
    "lukas-reineke/lsp-format.nvim",
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded"
      }
    },
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  { "nvim-treesitter/nvim-treesitter" },
  {
    "folke/lazy.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("lazy").setup({
        { "nvim-treesitter/nvim-treesitter" },
      })
    end,
  },
  {
    "leath-dub/snipe.nvim",
    keys = {
      { "gb", function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" }
    },
    opts = {}
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {},
    config = function()
      require("avante").setup({
        provider = "ollama",
        hvaints = {
          enabled = true,
        },
        vendors = {
          -- provider = "ollama"
          ---@type AvanteProvider
          ollama = {
            __inherited_from = "openai",
            api_key_name = "",
            endpoint = "https://tgi.fw.teslamotors.com/llama3-instruct/v1",
            model = "llama3.3",
          },
        },
      })
    end,
    keys = {
      { "<leader>aa", function() require("avante.api").ask() end,                desc = "avante: ask",    mode = { "n", "v" } },
      { "<leader>ar", function() require("avante.api").refresh() end,            desc = "avante: refresh" },
      { "<leader>ae", function() require("avante.api").edit() end,               desc = "avante: edit",   mode = "v" },
      { "<leader>ac", function() require("avante.api").ask({ ask = false }) end, desc = "avante: chat",   mode = "n" },
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    },
  },
  {
    "m4xshen/autoclose.nvim",
    event = "VeryLazy",
  },
  {
    "aaronik/treewalker.nvim",
    event = "VeryLazy",
    opts = {
      -- Whether to briefly highlight the node after jumping to it
      highlight = true,

      -- How long should above highlight last (in ms)
      highlight_duration = 250,

      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = 'CursorLine',
    },
    config = {
      -- movement
      vim.keymap.set({ 'n', 'v' }, '<C-k>', '<cmd>Treewalker Up<cr>', { silent = true }),
      vim.keymap.set({ 'n', 'v' }, '<C-j>', '<cmd>Treewalker Down<cr>', { silent = true }),
      vim.keymap.set({ 'n', 'v' }, '<C-l>', '<cmd>Treewalker Right<cr>', { silent = true }),
      vim.keymap.set({ 'n', 'v' }, '<C-h>', '<cmd>Treewalker Left<cr>', { silent = true }),

      -- swapping
      vim.keymap.set('n', '<C-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true }),
      vim.keymap.set('n', '<C-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true }),
      vim.keymap.set('n', '<C-S-l>', '<cmd>Treewalker SwapRight<CR>', { silent = true }),
      vim.keymap.set('n', '<C-S-h>', '<cmd>Treewalker SwapLeft<CR>', { silent = true }),
    }
  }
})
