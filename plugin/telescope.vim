nnoremap <C-P> <cmd>lua require('marce.telescope').git_files()<CR>
nnoremap <leader>n <cmd>lua require('marce.telescope').edit_neovim()<CR>
nnoremap <C-M> <cmd>lua require('marce.telescope').find_maa_ml_monorepo()<CR>
nnoremap <leader>mm <cmd>lua require('marce.telescope').live_grep_maa_ml_monorepo()<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string()<CR>
nnoremap <C-F> :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>f :lua require('telescope.builtin').file_browser()<CR>
nnoremap <leader>gb :lua require('marce.telescope').git_branches()<CR>
nnoremap <leader>gg <cmd>lua require('telescope.builtin').live_grep()<cr>
