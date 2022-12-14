require "kevz.util"
require "kevz.telescope"
require "kevz.git-worktree"
require "kevz.lsp"
require "kevz.statusline"
require "kevz.luasnip"
require "kevz.vimgui"
require "kevz.dressing"

local Remap = require("kevz.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

-- nvim-treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
  },
}

if (IsModuleAvailable("notify")) then
  local notify = require("notify")
  vim.notify = notify
  notify.setup({
      stages = "slide" -- fade_in_slide_out, fade, slide, static
    })

end

require("todo-comments").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}
require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

-- https://github.com/Yagua/nebulous.nvim
-- night
-- twilight
-- midnight
-- fullmoon
require("nebulous").setup {
  variant = "midnight",
  disable = { background = true, endOfBuffer = false },
  italic = {
    comments = false,
    keywords = true,
    functions = false,
    variables = true,
  },
  custom_colors = { -- this table can hold any group of colors with their respective values
    LineNr = { fg = "#5BBBDA", bg = "NONE", style = "NONE" },
    CursorLineNr = { fg = "#E1CD6C", bg = "NONE", style = "NONE" },

    -- it is possible to specify only the element to be changed
    TelescopePreviewBorder = { fg = "#A13413" },
    LspDiagnosticsDefaultError = { bg = "#E11313" },
    TSTagDelimiter = { style = "bold,italic" },
  },
}

require("symbols-outline").setup {
  -- whether to highlight the currently hovered symbol
  -- disable if your cpu usage is higher than you want it
  -- or you just hate the highlight
  -- default: true
  highlight_hovered_item = true,

  -- whether to show outline guides
  -- default: true
  show_guides = true,
}

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.wgsl = {
--   install_info = {
--     url = "$HOME/dev/tree-sitter-wgsl", -- local path or git repo
--     files = {"src/parser.c"}
--   },
--   filetype = "wgsl", -- if filetype does not agrees with parser name
--   used_by = {} -- additional filetypes that use this parser
-- }

require("nvim-treesitter.configs").setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
}
require("rest-nvim").setup({
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = true,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
    })

nnoremap("<leader>u", ":UndotreeShow<CR>")
inoremap("<C-c>", "<Esc>")
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
