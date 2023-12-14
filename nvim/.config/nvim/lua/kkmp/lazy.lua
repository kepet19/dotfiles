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
        tag = "0.1.5",
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
            require("hurl").setup({
                hurl_flags= {"--variables-file .env"}
            })
        end
    },
    {
        "rest-nvim/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("rest-nvim").setup({
                -- Open request results in a horizontal split
                result_split_horizontal = false,
                -- Keep the http file buffer above|left when split horizontal|vertical
                result_split_in_place = false,
                -- Skip SSL verification, useful for unknown certificates
                skip_ssl_verification = true,
                -- Encode URL before making request
                encode_url = true,
                -- Highlight request on run
                highlight = {
                    enabled = true,
                    timeout = 150,
                },
                result = {
                    -- toggle showing URL, HTTP info, headers at top the of result window
                    show_url = true,
                    -- show the generated curl command in case you want to launch
                    -- the same request via the terminal (can be verbose)
                    show_curl_command = false,
                    show_http_info = true,
                    show_headers = true,
                    -- executables or functions for formatting response body [optional]
                    -- set them to false if you want to disable them
                    formatters = {
                        json = "jq",
                        html = function(body)
                            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
                        end
                    },
                },
                -- Jump to request line on run
                jump_to_request = false,
                env_file = '.env',
                custom_dynamic_variables = {},
                yank_dry_run = true,
            })
        end
    }



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
