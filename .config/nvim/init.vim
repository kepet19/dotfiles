    let mapleader =","


" Pluging PLug {{{
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
" Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-eunuch'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'metakirby5/codi.vim'
Plug 'ajmwagar/vim-deus'
Plug 'mikelue/vim-maven-plugin'
Plug 'unfog-io/unfog-vim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'da-h/AirLatex.vim', {'do': ':UpdateRemotePlugins'}
Plug 'airblade/vim-rooter'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'hardcoreplayers/dashboard-nvim'
" Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

" }}}


" Pluging settings  {{{ 
	" Visual Vim clap {{{ 
		let g:clap_theme = 'material_design_dark'
		nnoremap <C-p> :Clap files<CR>
		nnoremap <Leader>fu :Clap grep<CR>
	" }}}
	"  AIR LATEX settings {{{ 
		" optional: set server name
			let g:AirlatexDomain="overleaf.nymann.dev"
			nmap <leader>a :AirLatex<CR>
		" LaTeX-Box is includ with vim-polyglot and may be disabled with: 
			let g:polyglot_disabled = ['latex']
	" }}}
	" VIMTEX AND AIRLINE {{{ 
		let g:vimtex_compiler_progname="nvr"
		let g:powerline_pycmd="py3"
		let g:airline_powerline_fonts = 1
		let g:airline_theme="solarized"
                let g:airline#extensions#tabline#enabled = 1
		
		" vimtex conf
		let g:tex_flavor='latex'
		let g:vimtex_view_method='zathura'
		let g:vimtex_quickfix_mode=0
		set conceallevel=1
		let g:tex_conceal='abdmg'
	" }}}
	" Git go to github homepage {{{
		map <leader>g :!urlgitf<CR>
	" }}} 
	" CocVim {{{ 
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
	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	" nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	nmap <F2> <Plug>(coc-rename)
	nmap <leader>rn <Plug>(coc-rename)
        nmap <leader>ac  <Plug>(coc-codeaction)
        nmap <leader>qf  <Plug>(coc-fix-current)
        " Use K to show documentation in preview window.
        nnoremap <silent> K :call <SID>show_documentation()<CR>
        
        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction
        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')
	" }}}
	" VimVikiIndex {{{ 
		map <leader>v :VimwikiIndex
	" }}}
        " Git Status {{{ 
		nnoremap <leader>gs :Gstatus<CR>
		nnoremap <leader>gc :Gcommit<CR>
		nnoremap <leader>gp :Gpush<CR>
        " }}}
" }}}


" Basic's, Mappings, Leader and stuff {{{ 
	" Some basics: {{{ 
		imap jk <Esc>
		set tabstop=8
		set softtabstop=0 expandtab
		set shiftwidth=4 smarttab
		set hidden " Has the buffer open ind the background
		set wildmenu " Tab compiltenmenu
		"set wildmode=longest:list,full
                " characters to show
                set listchars=tab:>~,nbsp:_,trail:.
                set list
		set wildmode=list:longest,list:full
		set wildignore+=/node_modules/** "ignore node_modules should add more
		set path+=** " Add subfolders aswell
		set bg=light
		set go=a
		set mouse=a
		set nohlsearch
		set clipboard+=unnamedplus
		set scrolloff=10 "Keeps the screecenter
		set nowrap!
		set nocompatible
		filetype plugin on
		syntax enable
		set encoding=utf-8
		set number relativenumber
	" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
		set splitbelow splitright
	" Mapping to change pwd to the directory of the current buffer.
		nnoremap cm :cd %:h<CR>:pwd<CR>
	" Toggle Wrap
		nnoremap <Leader>w :set wrap!<CR>
	" Removes pipes | that act as seperators on splits
		set fillchars+=vert:\ 
	" Change 2 split windows from vert to horiz or horiz to vert
		map <leader>th <C-w>t<C-w>H
		map <leader>tk <C-w>t<C-w>K
	" VIMRC
		nnoremap <leader>ev :vsp $MYVIMRC<CR>
		nnoremap <leader>sv :source $MYVIMRC <bar> :doautocmd BufRead<CR>
	" Replace all is aliased to S.
		nnoremap S :%s//g<Left><Left>
	" Open corresponding .pdf/.html or preview
		map <leader>p :!opout <c-r>%<CR><CR>
	" Format Json JSON
		map <leader>ff :%!jq .
	" }}}
	" netrw {{{ 
        map <leader>n e . <CR>
        let g:netrw_banner=0            " disable banner
        let g:netrw_browse_split=4      " open in prior window
        let g:netrw_altv=1              " open splits to the right
        let g:netrw_liststyle=3         " tree view
        let g:netrw_list_hide=netrw_gitignore#Hide()    " Hides files that is in gitignore
        let g:netrw_list_hide.='.class'                 " Hides class 
	" }}}	
	" Vim snippets I made {{{ 
	" }}}	
	" vim compileing opention {{{ 
		map <C-S-Up> :make<Return>:copen<Return>
		map <C-PageUp> :cprevious<Return>
		map <C-PageDown> :cnext<Return>
		map <leader>c :w! \| !compiler <c-r>%<CR>
		map <leader>t :w! \| !mvn test <CR>
	" }}}
	" Shortcutting split navigation, saving a keypress: {{{ 
		map <C-h> <C-w>h
		map <C-j> <C-w>j
		map <C-k> <C-w>k
		map <C-l> <C-w>l
	" }}}
	" Forresising vim spilts {{{ 
		" Does not work ind tmux...
		nnoremap <silent> <C-Left> :vertical resize +3<CR> 
		nnoremap <silent> <C-Right> :vertical resize -3<CR> 	
		nnoremap <silent> <C-Up> :resize +3<CR> 
		nnoremap <silent> <C-Down> :resize -3<CR> 
	" }}}
	" Copy selected lines as CSV {{{
		xnoremap <silent> <Leader>y :<C-u>call <SID>CopyLinesAsCSV()<CR>
		fun s:CopyLinesAsCSV() abort
		    let [_, l1, c1, _] = getpos("'<")
		    let [_, l2, c2, _] = getpos("'>")
		    let lines = map(getline(l1, l2), {i, l -> trim(l[c1-1:c2-1])})
		    call setreg(v:register, join(lines, ', '), 'l')
		endfun
	" }}}
	" SETS the 80 columline, cursorline and Transperrency {{{ 
		highlight ColorColumn ctermbg=235 guibg=#2c2d27
		" let &colorcolumn=join(range(81,999),",") " this is all from 81 and unwards
		" This Change the 80 columline and 120 and unwards
		let &colorcolumn="80,".join(range(120,999),",") 
		" Set the cursorline
		set cursorline
		" Makes wim transperrent
		hi Normal guibg=NONE ctermbg=NONE
	" }}}
	" Folding section {{{ 
		set foldenable
		set foldlevelstart=10
		set foldnestmax=10
		set foldmethod=syntax
	"	nnoremap <space> za "Open and close folds"
	" }}}
	" Vim color scheme {{{ 
		set t_Co=256
		set termguicolors
		let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
		let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
		set background=dark    " Setting dark mode
		colorscheme forest-night
	" }}}
" }}}


" speciel little things for vim {{{ 
	if has('persistent_undo')      "check if your vim version supports it
		set undofile                 "turn on the feature  
		set undodir=$HOME/.local/share/nvim/undo  "directory where the undo files will be store
	endif
" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>
" }}}


" AUTOCMD -----{{{ 

" Disables automatic commenting on newline:
"	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=da<CR>

" Spell correction the last word Ctrl + l
	inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
	
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writting
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=dark
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
	"autocmd BufWritePost ~/.config/waybar/config,~/.config/waybar/style.css !swaymsg "reload"
" Reload vim When it is changed
	augroup OnlyReloadOneTimePerWrite
    	au!
    	autocmd bufwritepost .vim source ~/.config/nvim/init.vim
	augroup END
" }}}


" THING I DON'T NEED ANYMORE {{{
	" Some Funky goingon? check this? {{{
	" nnoremap c "_c
	" }}}
"
" function! CheckIfBufferIsNotEmptyAndWriteGoClapFiles()
" 	if filereadable( bufname(1))
" 		:w!
" 	endif
" 	:Clap files
" endfunction
" 
" function! CheckIfBufferIsNotEmptyAndWriteGoClapGrep()
" 	if filereadable( bufname(1))
" 		:w!
" 	endif
" 	:Clap grep
" endfunction


" Vim clap Settings
" nnoremap <C-p> :call CheckIfBufferIsNotEmptyAndWriteGoClapFiles()<CR>
" nnoremap <Leader>fu :call CheckIfBufferIsNotEmptyAndWriteGoClapGrep()<CR> 
" }}}

" vim:foldmethod=marker:foldlevel=0
