Set-PSReadLineOption -EditMode vi
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Invoke-Expression (&starship init powershell)

