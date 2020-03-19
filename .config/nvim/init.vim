let mapleader =","
imap jk <Esc>

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'LukeSmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'kovetskiy/sxhkd-vim'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'sainnhe/vim-color-forest-night'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'metakirby5/codi.vim'
Plug 'ajmwagar/vim-deus'
Plug 'mikelue/vim-maven-plugin'
Plug 'unfog-io/unfog-vim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'da-h/AirLatex.vim', {'do': ':UpdateRemotePlugins'}
call plug#end()

function! CheckIfBufferIsNotEmptyAndWriteGoClapFiles()
	if filereadable( bufname(1))
		:w!
	endif
	:Clap files
endfunction

function! CheckIfBufferIsNotEmptyAndWriteGoClapGrep()
	if filereadable( bufname(1))
		:w!
	endif
	:Clap grep
endfunction

if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature  
  set undodir=$HOME/.config/nvim/undo  "directory where the undo files will be stored
  endif

" Vim clap Settings
nnoremap <C-p> :call CheckIfBufferIsNotEmptyAndWriteGoClapFiles()<CR>
nnoremap <C-b> :Gstatus<CR>
nnoremap <Leader>fu :call CheckIfBufferIsNotEmptyAndWriteGoClapGrep()<CR> 
" Visual Vim clap
let g:clap_theme = 'material_design_dark'


" optional: set server name
let g:AirlatexDomain="overleaf.nymann.dev"
nmap <leader>a :AirLatex<CR>
" LaTeX-Box is includ with vim-polyglot and may be disabled with: 
let g:polyglot_disabled = ['latex']

" Make go next and previus
map <C-S-Up> :make<Return>:copen<Return>
map <C-PageUp> :cprevious<Return>
map <C-PageDown> :cnext<Return>

" https://github.com/iamcco/coc-spell-checker

let g:vimtex_compiler_progname="nvr"
let g:powerline_pycmd="py3"
let g:airline_powerline_fonts = 1
let g:airline_theme="solarized"

" vimtex conf
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
xmap <Tab> <Plug>(coc-snippets-select)

" LukeSmithxyz
set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus

" Some basics:
	set tabstop=4
	set softtabstop=0 noexpandtab
	set shiftwidth=4
	nnoremap c "_c
" Mapping to change pwd to the directory of the current buffer.
	nnoremap cm :cd %:h<CR>:pwd<CR>
" Toggle Wrap
nnoremap <Leader>w :set wrap!<CR>

" VISUAL --- Mappings
	" Copy selected lines as CSV
	xnoremap <silent> <Leader>y :<C-u>call <SID>CopyLinesAsCSV()<CR>
	fun s:CopyLinesAsCSV() abort
	    let [_, l1, c1, _] = getpos("'<")
	    let [_, l2, c2, _] = getpos("'>")
	    let lines = map(getline(l1, l2), {i, l -> trim(l[c1-1:c2-1])})
	    call setreg(v:register, join(lines, ', '), 'l')
	endfun

	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
"	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=da<CR>

" Spell correction the last word Ctrl + l
	inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vimling:
	nm <leader>d :call ToggleDeadKeys()<CR>
	imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
	nm <leader>i :call ToggleIPA()<CR>
	imap <leader>i <esc>:call ToggleIPA()<CR>a
	nm <leader>q :call ToggleProse()<CR>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writting
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace on save.
"	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
" Reload Waybar
	autocmd BufWritePost ~/.config/waybar/config,~/.config/waybar/style.css !swaymsg "reload"
" Reload vim When it is changed
	augroup OnlyReloadOneTimePerWrite
    	au!
    	autocmd bufwritepost .vim source ~/.config/nvim/init.vim
	augroup END

" Vim color scheme
	set t_Co=256
	set termguicolors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set background=dark    " Setting dark mode
	colorscheme deus
" Makes wim transperrent
	hi Normal guibg=NONE ctermbg=NONE
