let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \}

let g:ale_fixers = {
      \    'python': ['yapf'],
      \   'javascript': ['prettier'],
      \   'css': ['prettier'],
      \}

nmap <leader>af :ALEFix<CR>
