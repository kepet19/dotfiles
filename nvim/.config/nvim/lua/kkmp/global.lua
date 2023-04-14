if vim.g.os == nil then
    if  vim.loop.os_uname().sysname == "Windows_NT" then
        vim.g.os = "Windows"
    else
        vim.g.os = vim.loop.os_uname().sysname
    end
end

vim.g.dotfiles_path = "$HOME/.dotfiles/"

if vim.g.os == "Windows" then
    vim.g.dotfiles_path = "$USERPROFILE/dev/Dotfiles/"
end

vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_cursor_animation_length=0
-- vim.g.neovide_refresh_rate = 60
-- vim.g.neovide_refresh_rate_idle = 5

vim.g.gui_font_default_size = 11
vim.g.gui_font_size = vim.g.gui_font_default_size

vim.g.gui_font_face = "Cascadia Code"
vim.g.gui_font_face = "FuraMono Nerd Font Mono"

