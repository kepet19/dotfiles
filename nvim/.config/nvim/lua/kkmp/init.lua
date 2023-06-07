require("kkmp.global")
require("kkmp.set")
require("kkmp.remap")
require("kkmp.lazy")

function R(name)
    require("plenary.reload").reload_module(name)
end


local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

local RemoveWhiteSpace = augroup('ThePrimeagen', {})

autocmd({"BufWritePre"}, {
    group = RemoveWhiteSpace,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.ldif = {
  install_info = {
    url = "~/dev/tree-sitter-ldif", -- local path or git repo
    files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- -- optional entries:
    -- generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "ldif", -- if filetype does not match the parser name
}
