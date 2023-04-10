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
