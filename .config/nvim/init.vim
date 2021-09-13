    let mapleader =" "


" Pluging PLug {{{
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'tjdevries/nlua.nvim'
" Plug 'nvim-lua/completion-nvim'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'mfussenegger/nvim-dap'
" Plug 'mfussenegger/nvim-jdtls'


" Project navigation
Plug 'ThePrimeagen/harpoon'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/preservim/nerdtree'

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'tjdevries/cyclist.vim'
" Plug 'itchyny/lightline.vim'

" Markdown and website
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.vim'
Plug 'mattn/emmet-vim'
Plug 'ferrine/md-img-paste.vim'

" Snippets 
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ferrine/md-img-paste.vim'

" visual color schemes and stuff
Plug 'nanotech/jellybeans.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/vim-color-forest-night'
Plug 'ayu-theme/ayu-vim'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug 'folke/lsp-colors.nvim'
" Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}

" status line
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Vim highlighter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ron-rs/ron.vim'
" Plug 'sheerun/vim-polyglot'

" Miss
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'airblade/vim-rooter'
Plug 'vuciv/vim-bujo'
Plug 'folke/todo-comments.nvim'
Plug 'folke/trouble.nvim'

" Format https://github.com/google/vim-codefmt
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
call plug#end()

" }}}

" Pluging settings  {{{
    " md-img-paste {{{
    autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
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
	" nvim-treesitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
EOF
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
        " UltiSnipsEdit {{{
		" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
		" - https://github.com/Valloric/YouCompleteMe
		" - https://github.com/nvim-lua/completion-nvim
		let g:UltiSnipsExpandTrigger="<C-e>"
		" let g:UltiSnipsListSnippets="<c-tab>"
		let g:UltiSnipsJumpForwardTrigger="<C-e>"
		let g:UltiSnipsJumpBackwardTrigger="<C-z>"
		" If you want :UltiSnipsEdit to split your window.
		let g:UltiSnipsEditSplit="vertical"
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
        " google/vim-codefmt {{{
        call glaive#Install()
        " Optional: Enable codefmt's default mappings on the <Leader>= prefix.
        Glaive codefmt plugin[mappings]
        Glaive codefmt google_java_executable="google-java-format -a"

        " }}}
        " ThePrimeagen/git-worktree.nvim {{{
        noremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
        noremap <leader>gc :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
        " }}}
" }}}

lua require("kevz")

" Basic's, Mappings, Leader and stuff {{{
	" Folding section {{{
		set foldenable
		set foldlevelstart=10
		set foldnestmax=10
		"set foldmethod=syntax
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
		set hidden " Has the buffer open ind the background
        " set listchars=tab:>~>,nbsp:_,trail:.
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
        set incsearch
		set signcolumn=yes
        set inccommand=split
		set clipboard+=unnamedplus
		set scrolloff=8 "Keeps the screecenter
		set nowrap
		set nocompatible
		set encoding=utf-8
		set number relativenumber
        set cmdheight=2
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
		nnoremap <leader>ev :vsp $MYVIMRC<CR>
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
    " Yank rest of the lines
    nnoremap Y yg_
    " keeping it centered
    nnoremap n nzzzv
    nnoremap N Nzzzv
    nnoremap J mzJ`z

    " add break points
    inoremap , ,<c-g>u
    inoremap . .<c-g>u
    inoremap ! !<c-g>u
    inoremap ? ?<c-g>u
    " inoremap [ [<c-g>u
    " inoremap ( (<c-g>u

    " add to the jump list
    nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
    nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

    " moving text
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv
    inoremap <C-j> <esc>:m .+1<CR>==
    inoremap <C-k> <esc>:m .-2<CR>==
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
        nnoremap <leader>n :NERDTreeCWD <CR>
        nnoremap <leader>nn :NERDTreeToggle <CR>
        let g:netrw_banner = 0            " disable banner
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
        
        lua require('colorbuddy').colorscheme('gruvbuddy')
        lua require("lsp-colors").setup()

		" colorscheme ayu
		" let g:nord_uniform_status_lines = 1
		" highlight ColorColumn ctermbg=235 guibg=#2c2d27
		let &colorcolumn="80"
		set cursorline
		" Makes wim transperrent
		hi Normal guibg=None ctermbg=None
	" }}}
	" vim-lsp settings {{{
		" Set completeopt to have a better completion experience
		" :help completeopt
		" menuone: popup even when there's only one match
		" noinsert: Do not insert text until a selection is made
		" noselect: Do not select, force user to select one from the menu
		set completeopt=menuone,noinsert,noselect


		" Configure LSP

		" Trigger completion with <Tab>

        inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
        imap <silent> <c-p> <Plug>(completion_trigger)
        " imap <tab> <Plug>(completion_smart_tab)
        " imap <s-tab> <Plug>(completion_smart_s_tab)
        " let g:completion_enable_auto_popup = 1

		" Code navigation shortcuts
		nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
		nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
		nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
		nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
		nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
		nnoremap <silent> <leader>gr    <cmd>lua vim.lsp.buf.rename()<CR>
		nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
    
        " Rest is implemed in telescope.plugin (not lua)
		" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
		" nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
		" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
		" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

		" Visualize diagnostics
		let g:diagnostic_enable_virtual_text = 1
		let g:diagnostic_trimmed_virtual_text = '40'
		" Don't show diagnostics while in insert mode
		let g:diagnostic_insert_delay = 1

        let g:completion_enable_snippet = 'UltiSnips'
		" Set updatetime for CursorHold
		" 300ms of no cursor movement to trigger CursorHold
		set updatetime=300
		" Show diagnostic popup on cursor hold
		" autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()

		" Goto previous/next diagnostic warning/error
		nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
		nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>
		autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
		\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }


        " Rust specefic stuff
        " Auto-format *.rs files prior to saving them
        " autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
        " " Use LSP omni-completion in Python files.
        " autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
	" }}}
" }}}

" AUTOCMD -----{{{
"   Augroup THE_KEVZ {{{
        augroup THE_KEVZ
            autocmd!
            " autocmd VimEnter * NERDTree | wincmd p
            autocmd VimLeave *.tex !texclear %

        " Ensure files are read as what I want:
            " autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
            " autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
            " autocmd BufRead,BufNewFile *.tex set filetype=tex

        " Save file as sudo on files that require root permission
            cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

        " Automatically deletes all trailing whitespace on save.
            autocmd BufWritePre *.{c,rs} %s/\s\+$//e

        " When shortcut files are updated, renew bash and ranger configs with new material:
            autocmd BufWritePost files,directories !shortcuts
        " Run xrdb whenever Xdefaults or Xresources are updated.
            autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
        " Update binds when sxhkdrc is updated.
            autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
        " reload waybar
            " autocmd bufwritepost ~/.config/waybar/config,~/.config/waybar/style.css !killall -SIGUSR2 waybar
        " reload mako
            autocmd bufwritepost ~/.config/mako/config !killall mako; mako & disown

            autocmd bufwritepost .vim source ~/.config/nvim/init.vim
        augroup END
    " }}}
"   Augroup lsp {{{
        " if has('nvim-0.5')
        "   augroup lsp
        "     au!
        "     au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}, root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml', '.git'})})
        "     au FileType java nnoremap ga <cmd>lua require('jdtls').code_action()<CR>
        "   augroup end
        " endif
    " }}}
    "   Augroup autoformat_settings {{{
    augroup autoformat_settings
        autocmd FileType bzl AutoFormatBuffer buildifier
        autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
        autocmd FileType dart AutoFormatBuffer dartfmt
        autocmd FileType go AutoFormatBuffer gofmt
        autocmd FileType gn AutoFormatBuffer gn
        autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
        autocmd FileType java AutoFormatBuffer google-java-format
        autocmd FileType python AutoFormatBuffer yapf
        " Alternative: autocmd FileType python AutoFormatBuffer autopep8
        autocmd FileType rust AutoFormatBuffer rustfmt
        autocmd FileType vue AutoFormatBuffer prettier
    augroup END
    " }}}
" }}}

" vim:foldmethod=marker:foldlevel=0
