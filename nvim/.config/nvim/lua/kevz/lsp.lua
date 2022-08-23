local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	--  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "<leader>dj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<leader>dk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action() <CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references({layout_strategy='vertical', layout_config = {width = 0.9}})<CR>", opts)
	buf_set_keymap("n", "g0", "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>", opts)
	buf_set_keymap("n", "gW", "<cmd>lua require'telescope.builtin'.lsp_workspace_symbols()<CR>", opts)
end

local lspkind = require("lspkind")
local cmp = require("cmp")
local compare = require("cmp.config.compare")
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- cmp.setup.cmdline(":", {
-- 	sources = {
-- 		{ name = "cmdline" },
-- 	},
-- })

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
		end,
	},
	mapping = {
		["<Tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				else
					cmp.complete()
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				else
					fallback()
				end
			end,
			s = function(fallback)
				fallback()
			end,
		}),
		["<S-Tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				else
					cmp.complete()
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				else
					fallback()
				end
			end,
			s = function(fallback)
				fallback()
			end,
		}),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		["<C-Space>"] = { i = cmp.mapping.complete({}) },
		["<c-y>"] = {
			i = cmp.mapping.confirm({ select = false }),
		},
		-- ["<c-y>"] = {
		-- i = cmp.mapping.confirm({ behavior = types.ConfirmBehavior.confirm }),
		-- },
		-- ["<C-y>"] = {
		-- 	i = cmp.mapping.confirm({ behavior = cmp.Confi}),
		-- },
		["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
		["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
		["<C-n>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				else
					vim.api.nvim_feedkeys(t("<Down>"), "n", true)
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				else
					fallback()
				end
			end,
		}),
		["<C-p>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				else
					vim.api.nvim_feedkeys(t("<Up>"), "n", true)
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				else
					fallback()
				end
			end,
		}),
		-- ['<CR>'] = cmp.mapping({
		--     i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		--     c = function(fallback)
		--         if cmp.visible() then
		--             cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
		--         else
		--             fallback()
		--         end
		--     end
		-- }),
	},

	sources = cmp.config.sources({
		-- { name = "cmp_tabnine" },
		{ name = "nvim_lua" }, --
		{ name = "luasnip", options = { use_show_conditions = false } }, -- For luasnip users.
		{ name = "zsh" }, --
		{ name = "nvim_lsp" }, --
		{ name = "path" }, --
		{ name = "latex_symbols" },
		-- { name = 'snippy' }, -- For snippy users.
	}, { { name = "buffer", keyword_length = 3 } }),

	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				-- cmp_tabnine = "[TN]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
				gh_issues = "[issues]",
			},
		}),
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			-- require("cmp_tabnine.compare"),
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
	view = { -- I like the new menu better! Nice work hrsh7th
		-- entries = "native",
		entries = "custom",
	},
	experimental = {
		-- Let's play with this for a day or two
		ghost_text = true,
	},
})

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	"pyright",
	"tsserver",
	"tsserver",
	"bashls",
	"texlab",
	"vimls",
	"jsonls",
	"gdscript",
	"html",
	"clangd",
	"gopls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
	})
end

lspconfig.csharp_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
  init_options = { AutomaticWorkspaceInit = false }
}

-- lspconfig.omnisharp.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = {
-- 		"C:/Users/kkmp/dev/omnisharp-win-x64/OmniSharp.exe",
-- 		"--languageserver",
-- 		"--hostPID",
-- 		tostring(vim.fn.getpid()),
-- 	},
-- 	flags = { debounce_text_changes = 150 },
-- })

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- lspconfig.jdtls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   flags = { debounce_text_changes = 150 },
--   cmd = { "java-lsp.sh" },
-- }
-- lspconfig.java_language_server.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   flags = { debounce_text_changes = 150 },
--   cmd = { "/home/kkmp/dev/java-language-server/dist/lang_server_linux.sh" },
-- }

-- vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Don't show the dumb matching stuff.
-- vim.opt.shortmess:append("c")

local opts = {
	tools = { -- rust-tools options
		-- automatically set inlay hints (type hints)
		-- There is an issue due to which the hints are not applied on the first
		-- opened file. For now, write to the file to trigger a reapplication of
		-- the hints or just run :RustSetInlayHints.
		-- default: true
		autoSetHints = true,

		runnables = {
			-- whether to use telescope for selection menu or not
			-- default: true
			use_telescope = true,

			-- rest of the opts are forwarded to telescope
		},

		inlay_hints = {
			-- wheter to show parameter hints with the inlay hints or not
			-- default: true
			show_parameter_hints = true,

			-- prefix for parameter hints
			-- default: "<-"
			parameter_hints_prefix = "<-",

			-- prefix for all the other hints (type, chaining)
			-- default: "=>"
			other_hints_prefix = "=>",

			-- whether to align to the lenght of the longest line in the file
			max_len_align = true,

			-- padding from the left if max_len_align is true
			max_len_align_padding = 1,

			-- whether to align to the extreme right or not
			right_align = false,

			-- padding from the right if right_align is true
			right_align_padding = 7,

			-- The color of the hints
			highlight = "Comment",
		},

		hover_actions = {
			border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			},
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
		flags = { debounce_text_changes = 150 },
	}, -- rust-analyer options
}

require("rust-tools").setup(opts)
-- require("lspconfig").rust_analyzer.setup(config({
--   cmd = { "rustup", "run", "nightly", "rust-analyzer"}
-- }))
