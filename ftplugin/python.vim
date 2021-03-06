nnoremap <buffer><leader>cp :Codi!! python<CR>

" Run the current buffer in Python
map <buffer><leader>r :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
