lua require("kevz")

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap ga <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
" nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap g0 <cmd>lua require('telescope.builtin').lsp_document_symbol()<cr>
nnoremap gW <cmd>lua require('telescope.builtin').lsp_workspace_symbol()<cr>
