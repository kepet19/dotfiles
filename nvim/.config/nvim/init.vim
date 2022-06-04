let mapleader =" "

if !exists("g:os")
	if has("win64") || has("win32") || has("win16")
		let g:os = "Windows"
	else
		let g:os = substitute(system('uname'), '\n', '', '')
	endif
endif


" if has("gui_running")
" 	if g:os == "Darwin"
" 		set guifont=Fira\ Mono:h12
" 	elseif g:os == "Linux"
" 		set guifont=Fira\ Mono\ 10
" 	elseif g:os == "Windows"
" 		set guifont=Fira_Mono:h12:cANSI
" 	endif
" endif


let install_path_script = './install.sh'
let g:config_path = '$HOME/.config/nvim/'

if g:os == "Windows"
    let g:config_path = '$USERPROFILE/AppData/Local/nvim/'
    let install_path_script = 'powershell ./install.ps1'
	"set shell=powershell
	"set shellcmdflag=-command
endif

" if g:os == "Linux" 
" endif

" echo g:config_path


" Pluging PLug {{{
if ! filereadable(expand(g:config_path . "autoload/plug.vim"))
	echo "Downloading junegunn/vim-plug to manage plugins... at: " . expand(g:config_path . "plug.vim")
	silent execute '!mkdir -p' . expand(g:config_path . "autoload")
	silent execute '!curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"> ' . expand(g:config_path . "autoload/plug.vim")
	autocmd VimEnter * PlugInstall
endif

call plug#begin(g:config_path . "plugged")

" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'tjdevries/nlua.nvim'
" Plug 'nvim-lua/completion-nvim'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'weilbith/nvim-code-action-menu'
Plug 'onsails/lspkind-nvim'

" Completions
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'kdheepak/cmp-latex-symbols'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'tzachar/cmp-tabnine', { 'do': install_path_script }


" Debug Adapter Protocol DAP
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'
" Plug 'leoluz/nvim-dap-go' "No  Go at the Moment


" Project navigation
Plug 'ThePrimeagen/harpoon'
Plug 'ThePrimeagen/git-worktree.nvim'


" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'tjdevries/cyclist.vim'

" Nvim special UI
Plug 'rcarriga/nvim-notify'
Plug 'stevearc/dressing.nvim'

" Markdown and website
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.vim'
Plug 'mattn/emmet-vim'
Plug 'ferrine/md-img-paste.vim'
Plug 'voldikss/vim-translator'


" visual color schemes and stuff
Plug 'folke/lsp-colors.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'nanotech/jellybeans.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/vim-color-forest-night'
Plug 'marko-cerovac/material.nvim'
Plug 'ayu-theme/ayu-vim'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug 'Yagua/nebulous.nvim'
Plug 'sainnhe/sonokai'
Plug 'navarasu/onedark.nvim'
Plug 'bennypowers/nvim-regexplainer'
" Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

" status line
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Tree Sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'
Plug 'p00f/nvim-ts-rainbow'

" Vim highlighter
Plug 'ron-rs/ron.vim'
Plug 'elkowar/yuck.vim'
Plug 'sheerun/vim-polyglot'

" Miss
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'airblade/vim-rooter'
Plug 'vuciv/vim-bujo'
Plug 'folke/todo-comments.nvim'
Plug 'folke/trouble.nvim'
Plug 'NTBBloodbath/rest.nvim'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Format 
Plug 'sbdchd/neoformat'

call plug#end()

" }}}

" Pluging settings  {{{
    " vim-translator {{{
    " Echo translation in the cmdline
    nmap <leader>rr <Plug>RestNvim
    nmap <leader>rp <Plug>RestNvimPreview
    nmap <silent> <leader>tg :!xdg-open "https://translate.google.com"<CR>
    nmap <silent> <leader>tt <Plug>Translate
    vmap <silent> <leader>tt <Plug>TranslateV
    " Display translation in a window
    " nmap <silent> <Leader>w <Plug>TranslateW
    " vmap <silent> <Leader>w <Plug>TranslateWV
    " Replace the text with translation
    " nmap <silent> <Leader>r <Plug>TranslateR
    " vmap <silent> <Leader>r <Plug>TranslateRV
    " Translate the text in clipboard
    " nmap <silent> <Leader>x <Plug>TranslateX
    let g:translator_target_lang='en'
    " Defaults
    "let g:translator_source_lang="auto"
    "let g:translator_default_engines="google" " bing, haici, iciba
    "let g:translator_proxy_url=""
    "let g:translator_history_enable=false
    " omfang
    "
    " }}}
    " md-img-paste {{{
    function! g:LatexPasteImage2(relpath)
    execute "normal! i\\includegraphics[width=1\\linewidth]{" . a:relpath . "}"
    endfunction

    autocmd FileType markdown,tex nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
    autocmd FileType markdown let g:PasteImageFunction = 'g:MarkdownPasteImage'
    autocmd FileType tex let g:PasteImageFunction = 'g:LatexPasteImage2'
    " there are some defaults for image directory and image name, you can change them
    " let g:mdip_imgdir = 'img'
    " let g:mdip_imgname = 'image'
    " }}}
	" cyclist {{{
    call cyclist#add_listchar_option_set('limited', {
                \ 'eol': '↲',
                \ 'tab': '» ',
                \ 'trail': '·',
                \ 'extends': '<',
                \ 'precedes': '>',
                \ 'conceal': '┊',
                \ 'nbsp': '␣',
                \ })
    call cyclist#set_eol('default', '')
    " Cycle to the next configuration
    " nmap <leader>cn <Plug>CyclistNext
    " nmap <leader>cp <Plug>CyclistPrev
	" }}}
	" Git go to github homepage {{{
		map <leader>g :!urlgitf<CR>
	" }}}
	" VimVikiIndex {{{
		map <leader>v :VimwikiIndex
	" }}}
        " Git Status {{{
		nnoremap <leader>gs :G<CR>
		nnoremap <leader>gcc :G commit<CR>
		nnoremap <leader>gp :G push<CR>
		nnoremap <leader>gj :diffget //3<CR>
		nnoremap <leader>gf :diffget //2<CR>
        " }}}
        " Emmet emmet-vim {{{
		let g:user_emmet_mode='n'
		let g:user_emmet_leader_key='<leader>'
		let g:user_emmet_install_global = 0
		autocmd FileType html,css EmmetInstall
        " }}}
        " vim rooter {{{
		let g:rooter_manual_only = 1
        " }}}
        " minimap {{{
		let g:minimap_left= 0
		let g:minimap_width = 10
		let g:minimap_highlight='TermCursor'
		let g:minimap_auto_start=0
		let g:minimap_base_highlight='Title'
		map <leader>mm :MinimapToggle<CR>
        " }}}
        " md-img-paste {{{
          " augroup md-img-paste
          "   au!
          "   autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
          " augroup end
        " there are some defaults for image directory and image name, you can change them
        " let g:mdip_imgdir = 'img'
        " let g:mdip_imgname = 'image'
        " }}}
        " vuciv/vim-bujo {{{
        let g:bujo#todo_file_path = $HOME . "/Documents"
        let g:bujo#window_width = 50
        " }}}
        "  sbdchd/neoformat {{{
        let g:neoformat_enabled_lua = ['stylua']
        " }}}
" }}}

lua require("kevz")
nnoremap <M-CR> <cmd>CodeActionMenu<cr>

" Basic's, Mappings, Leader and stuff {{{
	" Folding section {{{
        set foldenable
        set foldlevelstart=10
        set foldnestmax=10
        set foldmethod=expr
        set foldexpr=nvim_treesitter#foldexpr()

	"	nnoremap <space> za "Open and close folds"
	" }}}
	" Some basics: {{{
        set exrc
		set tabstop=4
		set softtabstop=0
        set expandtab
		set shiftwidth=4
        set smarttab
        set list
        set title
        set noswapfile
        set nobackup
        if has('persistent_undo')      "check if your vim version supports it
            set undodir=$HOME/.local/share/nvim/undo  "directory where the undo files will be store
            set undofile                 "turn on the feature
        endif
		" set shortmess+=c "Avoid showing extra messages when using completion
		" set wildmode=list:longest,list:full
		set path+=.,** " Add subfolders aswell
        set wildmode=longest,list,full
        set wildmenu
        " Ignore files
        set wildignore+=*.pyc
        set wildignore+=*_build/*
        set wildignore+=**/coverage/*
        set wildignore+=**/node_modules/*
        set wildignore+=**/android/*
        set wildignore+=**/ios/*
        set wildignore+=**/.git/*
		set go=a
		set mouse=a
		" set nohlsearch
        set ignorecase      " Do case insensitive search unless there are capital letters
        set incsearch       " Perform incremental searching
		set signcolumn=yes
        set inccommand=split
		set clipboard+=unnamedplus
		set scrolloff=8 "Keeps the screecenter
		set nowrap
		set nocompatible
		set encoding=utf-8
		set number relativenumber
        " set cmdheight=1
	" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
		" set splitbelow splitright
	" Mapping to change pwd to the directory of the current buffer.
		nnoremap cm :cd %:h<CR>:pwd<CR>
        "Enter for clear search!
        nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()
	" Toggle Wrap
		nnoremap <Leader>w :set wrap!<CR>
	" Removes pipes | that act as seperators on splits
		set fillchars+=vert:\
	" Change 2 split windows from vert to horiz or horiz to vert
		map <leader>th <C-w>t<C-w>H
		map <leader>tk <C-w>t<C-w>K
	" VIMRC
		nnoremap <leader>ev :lua require('kevz.telescope').search_vimfiles()<CR>
		nnoremap <leader>ef :lua require('kevz.telescope').search_dotfiles()<CR>
		nnoremap <leader>sv :source $MYVIMRC <bar> :doautocmd BufRead<CR>
	" Replace all is aliased to S.
		" nnoremap S :%s//g<Left><Left>
	" Open corresponding .pdf/.html or preview
		map <leader>p :!opout <c-r>%<CR><CR>
	" Format Json JSON
		"map <leader>ff :%!jq .
    " Compiler script
		map <leader>c :w! \| !compiler <c-r>%<CR>

    " Slide navigator
        nnoremap <Right> :n<CR>
        nnoremap <Left> :N<CR>
    " keeping it centered
    nnoremap n nzzzv
    nnoremap N Nzzzv
    nnoremap J mzJ`z

    " add break points (For when undoing stuff)
    inoremap , ,<c-g>u
    inoremap . .<c-g>u
    inoremap ! !<c-g>u
    inoremap ? ?<c-g>u
    inoremap [ [<c-g>u
    inoremap ( (<c-g>u

    " add to the jump list
    nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
    nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

    " moving text
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv
    inoremap <C-k> <esc>:m .-2<CR>==
    inoremap <C-j> <esc>:m .+1<CR>==
    nnoremap <leader>j :m .+1<CR>==
    nnoremap <leader>k :m .-2<CR>==

    " some test
    nnoremap cn *``cgn
    nnoremap cN *``cgN
	" }}}
    " Cheat.sh {{{
        function Cheat(query)
            let query = 'cheat.sh/' . a:query
            execute 'split | term curl ' . query
            execute 'resize ' . string(&lines/3)
        endfunction

        command! -nargs=1 CheatSh call Cheat(<q-args>)
        nnoremap <leader>h :CheatSh <C-R>=&filetype<CR>/
        " }}}
	" netrw {{{
        " let g:netrw_banner = 0            " disable banner
        " let g:netrw_browse_split=4      " open in prior window
        let g:netrw_browse_split=0
        " let g:netrw_winsize = 25
        let g:netrw_altv= 1              " open splits to the right
        let g:netrw_liststyle = 3         " tree view
        let g:netrw_list_hide=netrw_gitignore#Hide()    " Hides files that is in gitignore
        let g:netrw_list_hide.='.class'                 " Hides class
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
    " special things {{{
        " Check file in shellcheck:
        nnoremap <leader>s :!clear && shellcheck %<CR>

        " Spell-check set to <leader>o, 'o' for 'orthography':
        nnoremap <leader>od :setlocal spell! spelllang=da<CR>
        nnoremap <leader>oe :setlocal spell! spelllang=en<CR>

        nnoremap <leader>d "_d
        vnoremap <leader>d "_d

        " Spell correction the last word Ctrl + l
        inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
    " }}}
	" Vim color scheme {{{
		set t_Co=256
		" set background=dark    " Setting dark mode
		set termguicolors
		let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
		let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
		" colorscheme jellybeans
        " let ayucolor="dark"
        
        " lua require('colorbuddy').colorscheme('gruvbuddy')
        " lua require("lsp-colors").setup()
        " darker, lighter, oceanic, palenight, deep ocean,
        let g:material_style = 'deep ocean' 
        colorscheme tokyonight

		" colorscheme ayu
		" let g:nord_uniform_status_lines = 1
		" highlight ColorColumn ctermbg=235 guibg=#2c2d27
		let &colorcolumn="80"
		set cursorline
		" Makes wim transperrent
		" hi Normal guibg=None ctermbg=None
	" }}}
" }}}

" AUTOCMD -----{{{
    " FORMAT FMT {{{
    augroup fmt
      autocmd!
      " autocmd BufWritePre * undojoin | Neoformat
      " autocmd BufWritePre *\(^java\) Neoformat
      autocmd BufWritePre *\(^yaml\) Neoformat
    augroup END
    " }}}
    " Augroup THE_KEVZ {{{
        augroup THE_KEVZ
            autocmd!
            autocmd VimLeave *.tex !texclear %

        " Save file as sudo on files that require root permission
            cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

        " Automatically deletes all trailing whitespace on save.
            autocmd BufWritePre *.{c,rs} %s/\s\+$//e
        augroup END
    " }}}
    " Augroup highlight_yank {{{
        augroup highlight_yank
            autocmd!
            autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
        augroup END
    " }}}
" }}}

" vim:foldmethod=marker:foldlevel=0
