" =================== Basic Mappings ====================
"
" Quit and Write
imap jk <Esc>
map ; :
map wq :wq<CR>
map sa :q!<CR>
map qq :q<CR>
map R :source $MYVIMRC<CR>
map <leader>q :1,$d<CR>
map <M-d> :PlugInstall<CR>
noremap S :w<CR>
inoremap <C-s> <ESC> :w<CR>
" Window Next
noremap <C-p> :bp<CR>
noremap <C-m> :bn<CR>
" Space to Tab
nnoremap <LEADER>tt :%s/    /\t/g
vnoremap <LEADER>tt :s/    /\t/g
" Copy and Paste
inoremap <C-x> <ESC>yyddi
inoremap <M-x> <ESC>yypi
noremap tx :r !figlet


" ===================== Cursor Movement ================================
"
" Cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     k
" < h   l >
"     j
"     v
noremap <C-j> 5j
noremap <C-k> 5k
noremap <C-h> 5h
noremap <C-l> 5l
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-d> <Delete>
inoremap 5k <Esc>
inoremap 5j <Esc>
inoremap <C-d> <ESC>xi
" Faster in-line navigation
noremap W 5w
noremap B 5b


" ==================== Command Mode Cursor Movement ====================
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-w> <S-Right>


" ==================== Window management ====================
" Use <space> + new arrow keys for moving the cursor around windows
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap su :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap se :set splitbelow<CR>:split<CR>
noremap sn :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap si :set splitright<CR>:vsplit<CR>
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Resize splits with arrow keys
noremap <C-up> :res +5<CR>
noremap <C-down> :res -5<CR>
noremap <C-left> :vertical resize-5<CR>
noremap <C-right> :vertical resize+5<CR>


" ==================== Tab management ====================
"
" Create a new tab with tu
noremap tN :tabe<CR>
noremap <M-N> :tab split<CR>
" Move around tabs with tn and ti
noremap xl :-tabnext<CR>
noremap xr :+tabnext<CR>
" Move the tabs with tmn and tmi
noremap cl :-tabmove<CR>
noremap cr :+tabmove<CR>


" ==================== Markdown Settings ====================
"
" Snippets
" auto copy markdown code
nnoremap <silent><leader>yy <cmd>lua require('itkey.md').markdownCopyPlus()<CR>
source $HOME/.config/nvim/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell


noremap <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		set splitbelow
		:sp
		:res -5
		term gcc % -o %< && time ./%<
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'cs'
		set splitbelow
		silent! exec "!mcs %"
		:sp
		:res -5
		:term mono %<.exe
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'racket'
		set splitbelow
		:sp
		:res -5
		term racket %
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc

noremap <leader>e :vsplit<CR> :<C-u>Defx -listed -resume
      \ -columns=indent:mark:icon:icons:filename:git:size
      \ -buffer-name=tab`tabpagenr()`
      \ `expand('%:p:h')` -search=`expand('%:p')`<CR> :vertical resize-40<CR> :set nonu<CR> :set norelativenumber<CR>
