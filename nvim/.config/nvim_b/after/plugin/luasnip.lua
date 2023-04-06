-- local ls = require "luasnip"
-- local s = ls.s
-- local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep
-- local i = ls.insert_node

-- ls.snippets = {
--   all = {
--     ls.parser.parse_snippet("expand", "this is the text that is expanded"),
--   },

--   rust = {},
--   go = {},
--   lua = {
--     ls.parser.parse_snippet("mffff", "$1.$2 = function($3)\n  $0\nend"),
--     ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"),
--     s("req", fmt("local {} = require('{}')", { i(1), rep(1)})),
--   },
-- }
