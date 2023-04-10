local builtin = require('telescope.builtin')
local Path = require("plenary.path")

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)


vim.keymap.set("n", "<leader>pe", function()
    local myvimrc = vim.env["MYVIMRC"]
    local path_vim_init = Path:new(myvimrc)
    local path_config = path_vim_init:parent()
    builtin.find_files {
        prompt_title = "< VimRC >",
        cwd = path_config:absolute()
    }
end)

vim.keymap.set("n", "<leader>pd", function()
    builtin.find_files {
        prompt_title = "< ConfigFiles >",
        cwd = vim.g.config_path,
    }
end)
