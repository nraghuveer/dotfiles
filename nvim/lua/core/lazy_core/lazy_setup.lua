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
  { -- color schemes
    "vague2k/vague.nvim",
    "d00h/nvim-rusticated",
    "chiendo97/intellij.vim",
    "rebelot/kanagawa.nvim",
  },
  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    }
  },
  -- {
  --  "karb94/neoscroll.nvim",
  --  config = function ()
  --    require('neoscroll').setup({})
  --  end
  -- },
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
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "nvimdev/lspsaga.nvim",
    "lukas-reineke/lsp-format.nvim",

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
    lazy = false,
    version = false,
    build = "make BUILD_FROM_SOURCE=true",
    opts = {
      -- add any opts here
    },
    config = function()
      require("avante").setup({
        provider = "ollama",
        hints = {
          enabled = true,
        },
        vendors = {
          -- provider = "ollama", -- Only recommend using Claude
          ---@type AvanteProvider
          ollama = {
            ["local"] = true,
            endpoint = "https://tgi.fw.teslamotors.com/llama3-instruct/v1",
            model = "llama3.1",
            parse_curl_args = function(opts, code_opts)
              return {
                url = opts.endpoint .. "/chat/completions",
                headers = {
                  ["Accept"] = "application/json",
                  ["Content-Type"] = "application/json",
                },
                body = {
                  model = opts.model,
                  messages = require("avante.providers").openai.parse_message(code_opts),
                  temperature = 0,
                  max_tokens = 8192,
                  stream = true, -- this will be set by default.
                },
              }
            end,
            -- The below function is used if the vendors has specific SSE spec that is not claude or openai.
            parse_response_data = function(data_stream, event_state, opts)
              require("avante.providers").openai.parse_response(data_stream, event_state, opts)
            end,
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
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },

    },
    {
      dir = "/Users/rnaraharisetti/.config/bufhop.nvim",
      name = "bufhop",
      config = function()
        require('bufhop').setup()
      end
    },
    {
      -- Make sure to setup it properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  }
})
