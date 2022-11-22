vim.opt.termguicolors = true

vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_cursor_animation_length=0
vim.g.neovide_refresh_rate = 60
-- vim.g.neovide_refresh_rate_idle = 5

vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size

if (vim.g.os == "Windows") then
  vim.g.gui_font_face = "FuraMono Nerd Font Mono"
else
  vim.g.gui_font_face = "Fira Code Retina"
end

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function ()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({'n', 'i'}, "<C-+>", function() ResizeGuiFont(1)  end, opts)
vim.keymap.set({'n', 'i'}, "<C-->", function() ResizeGuiFont(-1) end, opts)
vim.keymap.set({'n', 'i'}, "<C-BS>", function() ResetGuiFont() end, opts)
