nnoremap <C-_> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>F <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap <leader>f <cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>

nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" ThePrimeagen/git-worktree.nvim {{{
noremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
noremap <leader>gc :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
" }}}

" Notifications notify
nnoremap <leader>n <cmd>Telescope notify<CR>
