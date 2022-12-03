local Remap = require "kevz.keymap"
local nnoremap = Remap.nnoremap
local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = " >",
    color_devicons = true,
  },
}

require("telescope").load_extension "git_worktree"
require("telescope").load_extension "fzy_native"
require("telescope").load_extension "file_browser"
require("telescope").load_extension "projects"

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

nnoremap("<leader>ps", function()
  require("telescope.builtin").grep_string { search = vim.fn.input "Grep For > " }
end)

nnoremap("<leader>fr", require("telescope.builtin").resume)
nnoremap("<leader>ff", require("telescope.builtin").find_files)
--nnoremap("<leader>F", require('telescope.builtin').find_files)
nnoremap("<leader>F", require("telescope").extensions.file_browser.file_browser)
nnoremap("<leader>fb", require("telescope.builtin").buffers)
nnoremap("<leader>fh", require("telescope.builtin").help_tags)
nnoremap("<leader>fg", function()
  require("telescope.builtin").live_grep { layout_strategy = "vertical", layout_config = { width = 0.9 } }
end)

nnoremap("<leader>fp", require("telescope").extensions.projects.projects)
nnoremap("<leader>gw", require("telescope").extensions.git_worktree.git_worktrees)
nnoremap("<leader>gc", require("telescope").extensions.git_worktree.create_git_worktree)
nnoremap("<leader>n", require("telescope").extensions.notify.notify)

return M
