"paste
map <M-v> "+gp
map <M-Left> :bprevious<CR>
map <M-Right> :bnext<CR>
map <C-n> :tabnew<CR>
map <M-q> :confirm quit<CR>
map <C-s> :write<CR>
map <M-j> gt
map <M-k> gT

"go to beginning of command line
cnoremap <C-A> <Home>

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


"from http://vim.wikia.com/wiki/Transposing#Swapping_lines
function! MoveLineUp()
	call MoveLineOrVisualUp(".", "")
endfunction

function! MoveLineDown()
	call MoveLineOrVisualDown(".", "")
endfunction

function! MoveVisualUp()
	call MoveLineOrVisualUp("'<", "'<,'>")
	normal gv
endfunction

function! MoveVisualDown()
	call MoveLineOrVisualDown("'>", "'<,'>")
	normal gv
endfunction

function! MoveLineOrVisualUp(line_getter, range)
	let l_num = line(a:line_getter)
	if l_num - v:count1 - 1 < 0
		let move_arg = "0"
	else
		let move_arg = a:line_getter." -".(v:count1 + 1)
	endif
	call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! MoveLineOrVisualDown(line_getter, range)
	let l_num = line(a:line_getter)
	if l_num + v:count1 > line("$")
		let move_arg = "$"
	else
		let move_arg = a:line_getter." +".v:count1
	endif
	call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! MoveLineOrVisualUpOrDown(move_arg)
	let col_num = virtcol(".")
	execute "silent! ".a:move_arg
	execute "normal! ".col_num."|"
endfunction

nnoremap <silent> <C-Up>	 :<C-u>call MoveLineUp()<CR>
nnoremap <silent> <C-Down> :<C-u>call MoveLineDown()<CR>
inoremap <silent> <C-Up>	 <C-o>:call MoveLineUp()<CR>
inoremap <silent> <C-Down> <C-o>:call MoveLineDown()<CR>
"vnoremap <silent> <C-Up> :<C-u>call MoveVisualUp()<CR>
"vnoremap <silent> <C-Down> :<C-u>call MoveVisualDown()<CR>
xnoremap <silent> <C-Up>	 :<C-u>call MoveVisualUp()<CR>
xnoremap <silent> <C-Down> :<C-u>call MoveVisualDown()<CR>
