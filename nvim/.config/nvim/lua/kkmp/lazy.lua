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
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup({
            })
        end
    },
    "rose-pine/neovim",
    -- Color scheme helpers
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "MTDL9/vim-log-highlighting",

    -- functionally
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    "theprimeagen/harpoon",
    "mbbill/undotree",
    "tpope/vim-commentary",
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            {
                'jose-elias-alvarez/null-ls.nvim',
                config = function()
                    local null_ls = require("null-ls")
                    null_ls.setup({
                        sources = {
                            -- null_ls.builtins.diagnostics.cspell, null_ls.builtins.code_actions.cspell
                            null_ls.builtins.formatting.xmllint.with({
                                timeout = 10000
                            })
                        }
                    })
                end
            },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },

    -- PlanetUml
    {
        'weirongxu/plantuml-previewer.vim',
        config = function()
            vim.g.plantuml_previewer = 'pdf' --Default png
        end
        ,

        dependencies = {
            { 'tyru/open-browser.vim' }, -- Required
            { 'aklt/plantuml-syntax' }, -- Optional
        },
    },

    -- PlanetUml Preview inside .uml files
    -- {
    --     'scrooloose/vim-slumlord',
    --     config = function()
    --     end
    --     ,

    --     dependencies = {
    --         { 'aklt/plantuml-syntax' }, -- Optional
    --     },
    -- },
}, opts)
