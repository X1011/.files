"replace line with yanked line
map <M-0> V"0p

"copy
map <c-c> "+y
noremap <m-c> <c-c>
map ^w^c ^wc
"copy all
"map <c-s-c> :%yank +<cr>

"paste
map <c-v> "+P
map! <c-v> <C-r>+
noremap <m-v> <c-v>
noremap g<c-v> <c-v>

map <M-Left> :bprevious<CR>
map <M-Right> :bnext<CR>
map <C-n> :tabnew<CR>
map <m-q> :confirm quit<CR>
imap <m-q> <c-o><m-q>

map <silent> <M-j> :tabnext<CR>
map <silent> <M-k> :tabprevious<CR>
imap <m-j> <c-o><m-j>
imap <m-k> <c-o><m-k>

nmap <C-s> :Update<CR>
imap <C-s> <c-o>:Update<CR>

"function! nimap(

"readline/emacs-like bindings for insert and command line
noremap! <C-a> <home>
noremap! <C-f> <right>
noremap! <C-b> <left>

noremap ; :
noremap ' ;

set directory=~/.cache/vim,/var/tmp/vim,.,/tmp/vim
set ignorecase "use case insensitive search
set smartcase  "except when using capital letters
set guicursor+=a:blinkon0
set shiftwidth=4
set tabstop=4
set showcmd "Show partial commands in the last line of the screen

syntax enable

augroup vimrc
	autocmd!
	autocmd BufWritePost .vimrc,.gvimrc source $MYVIMRC | if has('gui_running') | source $MYGVIMRC | endif
augroup END


" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif


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
