nnoremap <C-P> <cmd>lua require('marce.telescope').git_files()<CR>
nnoremap <leader>en <cmd>lua require('marce.telescope').edit_neovim()<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-F> :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>f :lua require('telescope.builtin').file_browser()<CR>
nnoremap <leader>gb :lua require('marce.telescope').git_branches()<CR>
