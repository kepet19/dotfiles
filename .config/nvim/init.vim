    let mapleader =","


" Pluging PLug {{{
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mfussenegger/nvim-jdtls'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sainnhe/vim-color-forest-night'
Plug 'tjdevries/cyclist.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'lervag/vimtex'
" Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'airblade/vim-rooter'
Plug 'iamcco/markdown-preview.vim'
Plug 'mattn/emmet-vim'
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'KabbAmine/vCoolor.vim'

call plug#end()

" }}}


" Pluging settings  {{{
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
	" nvim-telescope {{{
        " Using lua functions
lua << EOF
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=always',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
  }
}
EOF

        nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
        nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
        nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
        nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
        nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
        nnoremap ga <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
		" nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
        nnoremap g0 <cmd>lua require('telescope.builtin').lsp_document_symbol()<cr>
        nnoremap gW <cmd>lua require('telescope.builtin').lsp_workspace_symbol()<cr>
	" }}}
	" Lightline {{{
		let g:lightline = {
					\ 'colorscheme': 'nord',
					\ 'active': {
					\   'left': [ [ 'mode', 'paste' ],
					\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
					\ },
					\ 'component_function': {
					\   'gitbranch': 'FugitiveHead'
					\ },
					\ }

		" vimtex conf
		let g:tex_flavor='latex'
		let g:vimtex_view_method='zathura'
		let g:vimtex_quickfix_mode=0
		set conceallevel=0
		let g:tex_conceal='abdmg'
	" }}}
	" Git go to github homepage {{{
		map <leader>g :!urlgitf<CR>
	" }}}
	" nvim-treesitter {{{
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"     disable = {},  -- list of language that will be disabled
"   },
" }
" EOF
	" }}}
	" VimVikiIndex {{{
		map <leader>v :VimwikiIndex
	" }}}
        " Git Status {{{
		nnoremap <leader>gs :G status<CR>
		nnoremap <leader>gc :G commit<CR>
		nnoremap <leader>gp :G push<CR>
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
		let g:UltiSnipsJumpBackwardTrigger="<c-z>"
		" If you want :UltiSnipsEdit to split your window.
		let g:UltiSnipsEditSplit="vertical"
        " }}}
" }}}


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
		imap jk <Esc>
		set tabstop=4
		set softtabstop=0 expandtab
		set shiftwidth=4 smarttab
		set hidden " Has the buffer open ind the background
        " set listchars=tab:>~>,nbsp:_,trail:.
        set list
		set wildmode=list:longest,list:full
		set wildignore+=/node_modules/** "ignore node_modules should add more
		set path+=** " Add subfolders aswell
		set go=a
		set mouse=a
		" set nohlsearch
        set inccommand=split
		set clipboard+=unnamedplus
		set scrolloff=5 "Keeps the screecenter
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
		nnoremap S :%s//g<Left><Left>
	" Open corresponding .pdf/.html or preview
		map <leader>p :!opout <c-r>%<CR><CR>
	" Format Json JSON
		"map <leader>ff :%!jq .
    " Compiler script
		map <leader>c :w! \| !compiler <c-r>%<CR>

    " Slide navigator
        nnoremap <Right> :n<CR>
        nnoremap <Left> :N<CR>
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
	" vim-lsp settings {{{
		" Set completeopt to have a better completion experience
		" :help completeopt
		" menuone: popup even when there's only one match
		" noinsert: Do not insert text until a selection is made
		" noselect: Do not select, force user to select one from the menu
		set completeopt=menuone,noinsert,noselect

		" Avoid showing extra messages when using completion
		" set shortmess+=c

		" Configure LSP
		" https://github.com/neovim/nvim-lspconfig#rust_analyzer
:lua <<EOF

-- lspconfig object
local lspconfig = require'lspconfig'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
-- Enable html
-- Enable gdscript
-- Enable tsserver
lspconfig.rust_analyzer.setup({ on_attach=on_attach })
lspconfig.html.setup({ on_attach=on_attach })
lspconfig.cssls.setup({ on_attach=on_attach })
lspconfig.gdscript.setup({ on_attach=on_attach })
lspconfig.tsserver.setup({ on_attach=on_attach })
lspconfig.jsonls.setup({ on_attach=on_attach })
lspconfig.vimls.setup({ on_attach=on_attach })
lspconfig.bashls.setup({ on_attach=on_attach })
lspconfig.texlab.setup({ on_attach=on_attach })

EOF

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
		" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
		" nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
		" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
		" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

		" Visualize diagnostics
		set signcolumn=yes
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
        autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
        " Use LSP omni-completion in Python files.
        autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
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
	" Vim color scheme {{{
		" set t_Co=256
		" set background=dark    " Setting dark mode
		" set termguicolors
		" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
		" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
		colorscheme nord
		" let g:nord_uniform_status_lines = 1
		" highlight ColorColumn ctermbg=235 guibg=#2c2d27
		let &colorcolumn="80"
		set cursorline
		" Makes wim transperrent
		" hi Normal guibg=None ctermbg=None
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
	map <leader>od :setlocal spell! spelllang=da<CR>
	map <leader>oe :setlocal spell! spelllang=en<CR>

" Spell correction the last word Ctrl + l
	inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/Documents/SDU/', 'syntax': 'markdown', 'ext': '.md'}, {'path': '~/SDU/', 'syntax': 'markdown', 'ext': '.md'}]
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
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
" reload waybar
	autocmd bufwritepost ~/.config/waybar/config,~/.config/waybar/style.css !killall -SIGUSR2 waybar
" reload mako
	autocmd bufwritepost ~/.config/mako/config !killall mako; mako & disown
" Reload vim When it is changed
	augroup OnlyReloadOneTimePerWrite
    	au!
    	autocmd bufwritepost .vim source ~/.config/nvim/init.vim
	augroup END
" }}}

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}, root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml', '.git'})})
    au FileType java nnoremap ga <cmd>lua require('jdtls').code_action()<CR>
  augroup end
endif

" vim:foldmethod=marker:foldlevel=0
