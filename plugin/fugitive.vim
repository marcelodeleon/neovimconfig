" Make vimdiff use vertical splits for 3-way merges
set diffopt=vertical

" Deletes any Fugitive buffer after exiting
autocmd BufReadPost fugitive://* set bufhidden=delete
