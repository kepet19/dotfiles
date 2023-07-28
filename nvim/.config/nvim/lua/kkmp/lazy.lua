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
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
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
    -- "tpope/vim-commentary",
    "tpope/vim-fugitive",
    "tpope/vim-surround",
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
                            }),
                            null_ls.builtins.formatting.sql_formatter,
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
    {
        'numToStr/Comment.nvim',
        config = function()
            local comment = require("Comment")
            comment.setup()
        end
    },

    -- nushell stuff
    {
        'LhKipp/nvim-nu',
        config = function()
            local nu = require("nu")
            nu.setup({
                use_lsp_features = true,
                all_cmd_names = [[nu -c 'help commands | get name | str join "\n"']]
            })
        end
    },

    -- PlanetUml
    {
        'weirongxu/plantuml-previewer.vim',
        config = function()
            vim.g['plantuml_previewer#save_format'] = 'pdf' --Default png
            vim.g['plantuml_previewer#debug_mode'] = 1 --Default 0

        end
        ,

        dependencies = {
            { 'tyru/open-browser.vim' }, -- Required
            { 'aklt/plantuml-syntax' }, -- Optional
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            {
                "pfeiferj/nvim-hurl",
                branch="main",
            }
        },
        config = function()
            -- add hurl to the nvim-treesitter config
            require("hurl").setup()
        end
    };

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
