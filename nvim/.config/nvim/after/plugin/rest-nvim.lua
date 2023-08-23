local rest = require('rest-nvim')
local save = function()
    local filename = vim.api.nvim_buf_get_name(0);
    vim.cmd.write { filename, bang = false }
end

vim.keymap.set('n', '<leader>rr', function()
    save()
    rest.run()
end) -- RestNvim
vim.keymap.set('n', '<leader>rp', function()
    save()
    rest.run(true)
end) -- RestNvimPreview
vim.keymap.set('n', '<leader>rl', function()
    save()
    rest.last()
end) -- RestNvimLast
