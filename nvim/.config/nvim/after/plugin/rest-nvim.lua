local rest = require('rest-nvim')
vim.keymap.set('n', '<leader>rr', function() rest.run() end) -- RestNvim
vim.keymap.set('n', '<leader>rp', function() rest.run(true) end) -- RestNvimPreview
vim.keymap.set('n', '<leader>rl', function() rest.last() end) -- RestNvimLast
