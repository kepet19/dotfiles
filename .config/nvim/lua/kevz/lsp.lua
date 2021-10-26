-- lspconfig object
-- https://github.com/neovim/nvim-lspconfig#rust_analyzer
local lspconfig = require'lspconfig'

-- function to attach completion and diagnostics
-- when setting up lsp
-- lspconfig.clangd.setup({})
-- lspconfig.html.setup({})
-- lspconfig.cssls.setup({})
-- lspconfig.gdscript.setup({})
-- lspconfig.tsserver.setup({})
-- lspconfig.jsonls.setup({})
-- lspconfig.vimls.setup({})
-- lspconfig.bashls.setup({})
-- lspconfig.texlab.setup({})
-- lspconfig.jdtls.setup{ cmd = { 'java-lsp.sh' } }
lspconfig.java_language_server.setup({
    cmd = {"/home/kkmp/dev/java-language-server/dist/lang_server_linux.sh"};
})
