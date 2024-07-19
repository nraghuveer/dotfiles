local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use ({ 'projekt0n/github-nvim-theme' })
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use {
	  'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "glepnir/lspsaga.nvim",
  }
  use {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  }

 --harpoon
 use {
		'ThePrimeagen/harpoon',
	requires = { {'nvim-lua/plenary.nvim'} }
 }

  use 'lewis6991/gitsigns.nvim'
  -- tabs
  use 'romgrk/barbar.nvim'
  use({
  	"Pocco81/auto-save.nvim",
	config = function()
		 require("auto-save").setup {}
	end,
  })
  -- indent lines
  use "lukas-reineke/indent-blankline.nvim"
  use 'ThePrimeagen/git-worktree.nvim'
  use 'lukas-reineke/lsp-format.nvim'
  use 'rmagatti/auto-session'
  use "rebelot/kanagawa.nvim"
  use "vague2k/vague.nvim"
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
