local Remap = require("kevz.keymap")
local nnoremap = Remap.nnoremap
local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"

require("telescope").setup {
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = " >",
    color_devicons = true,
    layout_config = {
      vertical = { width = 0.9 }
    },

    -- file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    -- grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    -- qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    pickers = {
      lsp_references = {
        theme = "dropdown",
      }
    },

    mappings = {
      i = {
        ["<C-j>"] = {
          action = actions.move_selection_next,
        },
        ["<C-k>"] = {
          action = actions.move_selection_previous,
        },
        ["<M-P>"] = action_layout.toggle_preview,
      },
      n = {
        ["<M-P>"] = action_layout.toggle_preview,
      },
    },
  },
}

nnoremap("<leader>ps", function()
    require('telescope.builtin').grep_string({layout_strategy='vertical', layout_config = {width = 0.9} ,search = vim.fn.input("Grep For > ")})
end)

require("telescope").load_extension "git_worktree"
require("telescope").load_extension "fzy_native"
require("telescope").load_extension "file_browser"
-- require('telescope').load_extension('dap')

if IsModuleAvailable "ui-select" then
  require("telescope").load_extension "ui-select"
end

if IsModuleAvailable "notify" then
  require("telescope").load_extension "notify"
end

local M = {}
M.search_vimfiles = function()
  require("telescope.builtin").find_files {
    prompt_title = "< VimRC >",
    cwd = vim.g.config_path,
  }
end

M.search_dotfiles = function()
  require("telescope.builtin").find_files {
    prompt_title = "< ConfigFiles >",
    cwd = vim.g.config_path,
  }
end

-- map(mode, key, lua function to call)
--
-- good place to look: telescope.actions (init.lua)
-- lua function to call:  (gets bufnr, not necessarily needed)
--   require('telescope.actions.state').get_selected_entry(bufnr)
--   Actions just take the bufnr and give out information
--   require('telescope.actions').close(bufnr)
--
--   check out telescope.actions for _all the available_ supported
--   actions.
--
--   :h telescope.setup ->
--   :h telescope.builtin ->
--   :h telescope.layout ->
--   :h telescope.actions
--
local function set_background(content)
  vim.fn.system("setbg " .. content)
end

local function select_background(prompt_bufnr, map)
  local function set_the_background(close)
    local content = require("telescope.actions.state").get_selected_entry()
    set_background(content.cwd .. "/" .. content.value)
    if close then
      require("telescope.actions").close(prompt_bufnr)
    end
  end

  map("i", "<C-p>", function()
    set_the_background()
  end)

  map("i", "<CR>", function()
    set_the_background(true)
  end)
end

local function image_selector(prompt, cwd)
  return function()
    require("telescope.builtin").find_files {
      prompt_title = prompt,
      cwd = cwd,

      attach_mappings = function(prompt_bufnr, map)
        select_background(prompt_bufnr, map)

        -- Please continue mapping (attaching additional key maps):
        -- Ctrl+n/p to move up and down the list.
        return true
      end,
    }
  end
end

M.background_selector = image_selector("< Wallpapers > ", "~/Pictures/Wallpapers/")

M.git_branches = function()
  require("telescope.builtin").git_branches {
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.git_delete_branch)
      map("n", "<c-d>", actions.git_delete_branch)
      return true
    end,
  }
end

return M
