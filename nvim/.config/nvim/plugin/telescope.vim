nnoremap <C-_> <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap <leader>F <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>F <cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>

nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep({layout_strategy='vertical', layout_config = {width = 0.9}})<cr>
nnoremap <leader>fp <cmd>lua require('telescope').extensions.projects.projects{}<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" ThePrimeagen/git-worktree.nvim {{{
noremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
noremap <leader>gc :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
" }}}

" command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({layout_strategy='vertical', layout_config = {width = 0.9} ,search = vim.fn.input("Grep For > ")})

" Notifications notify
nnoremap <leader>n <cmd>Telescope notify<CR>
