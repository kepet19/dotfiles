require "kevz.vimgui"
require "kevz.util"

vim.g.git_worktree_log_level = "trace" -- trace, debug, info, warn, error, fatal

require "kevz.telescope"
require "kevz.git-worktree"
require "kevz.lsp"
require "kevz.statusline"
-- require "kevz.k_luasnip"
require "kevz.dressing"
local Remap = require("kevz.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

require('gitsigns').setup()
require("project_nvim").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

if (IsModuleAvailable("tokyonight")) then
  require("tokyonight")
end

if (IsModuleAvailable("notify")) then
  local notify = require("notify")
  vim.notify = notify
  notify.setup({
      stages = "static", -- fade_in_slide_out, fade, slide, static
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


require("nvim-treesitter.configs").setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    use_languagetree = false,
    disable = function(_, bufnr)
      local buf_name = vim.api.nvim_buf_get_name(bufnr)
      local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
      return file_size > 256 * 1024
    end,
  },

  rainbow = {
    enable = true,
    additional_vim_regex_highlighting = false,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 10000, -- Do not enable for files with more than n lines, int
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
