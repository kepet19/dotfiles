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

vim.keymap.set({'n', 'i'}, "<C-ScrollWheelUp>", function() ResizeGuiFont(1)  end)
vim.keymap.set({'n', 'i'}, "<C-ScrollWheelDown>", function() ResizeGuiFont(-1) end)
vim.keymap.set({'n', 'i'}, "<C-BS>", function() ResetGuiFont() end)
