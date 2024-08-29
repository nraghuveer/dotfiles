-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
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
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter" }, -- Treesitter is a high-performance syntax highlighter for Neovim.
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
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	opts = {
	-- add any opts here
	},
	keys = {
	{ "<leader>aa", function() require("avante.api").ask() end, desc = "avante: ask", mode = { "n", "v" } },
	{ "<leader>ar", function() require("avante.api").refresh() end, desc = "avante: refresh" },
	{ "<leader>ae", function() require("avante.api").edit() end, desc = "avante: edit", mode = "v" },
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
	{
		-- Make sure to setup it properly if you have lazy=true
		'MeanderingProgrammer/render-markdown.nvim',
		opts = {
		file_types = { "markdown", "Avante" },
		},
		ft = { "markdown", "Avante" },
	},
	},
}

})

