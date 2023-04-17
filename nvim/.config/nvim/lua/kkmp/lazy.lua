-- Boostrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Color schemes
	"folke/tokyonight.nvim",
    {"folke/todo-comments.nvim",
    config = function()
        require("todo-comments").setup({
        }

        )
    end
},
	"rose-pine/neovim",
	-- Color scheme helpers
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    "MTDL9/vim-log-highlighting",

	-- functionally
	{
		"nvim-telescope/telescope.nvim", tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	"theprimeagen/harpoon",
	"mbbill/undotree",
    "tpope/vim-commentary",
	"tpope/vim-fugitive",
    {"lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end
    },

	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
			'williamboman/mason.nvim',
			build = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
		},
		{'williamboman/mason-lspconfig.nvim'}, -- Optional

		-- Autocompletion
		{'hrsh7th/nvim-cmp'},     -- Required
		{'hrsh7th/cmp-nvim-lsp'}, -- Required
		{'L3MON4D3/LuaSnip'},     -- Required
	}
}
}, opts)
