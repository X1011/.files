map <C-n> :tabnew<CR>
map <M-q> :confirm quit<CR>
map <C-s> :w<CR>
map <M-j> gt
map <M-k> gT

set ignorecase
set smartcase
set guicursor+=a:blinkon0
set shiftwidth=4
set tabstop=4

syntax enable

augroup vimrc
	autocmd!
	autocmd BufWritePost .vimrc,.gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END
