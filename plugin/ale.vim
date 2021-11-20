let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \}

let g:ale_fixers = {
      \    'python': ['black', 'isort'],
      \   'javascript': ['prettier'],
      \   'css': ['prettier'],
      \}

let g:ale_python_black_options = '--line-length 88'
let g:ale_python_isort_options = '--profile black'

nmap <leader>af :ALEFix<CR>
