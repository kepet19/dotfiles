-- lspconfig object
-- https://github.com/neovim/nvim-lspconfig#rust_analyzer
local lspconfig = require'lspconfig'

-- function to attach completion and diagnostics
-- when setting up lsp
vim.lsp.set_log_level("debug")
local on_attach = function(client)
    -- require'completion'.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

lspconfig.rust_analyzer.setup({ on_attach=on_attach, capabilities = capabilities, })
lspconfig.html.setup({ on_attach=on_attach })
lspconfig.cssls.setup({ on_attach=on_attach })
lspconfig.gdscript.setup({ on_attach=on_attach })
lspconfig.tsserver.setup({ on_attach=on_attach })
lspconfig.jsonls.setup({ on_attach=on_attach })
lspconfig.vimls.setup({ on_attach=on_attach })
lspconfig.bashls.setup({ on_attach=on_attach })
lspconfig.texlab.setup({ on_attach=on_attach })
lspconfig.java_language_server.setup({
    cmd = {"/home/kkmp/dev/java-language-server/dist/lang_server_linux.sh"};
    on_attach=on_attach
})

local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides
    -- default: true
    show_guides = true,
}

require('symbols-outline').setup(opts)