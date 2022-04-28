Function mvc {Set-Location -Path ~/dev/mvc_dev/MVCPortal/MVCPortal/}
Function dev {Set-Location -Path ~/dev/}


function co
{
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({
            param($pCmd, $pParam, $pWord, $pAst, $pFakes)

            $branchList = (git branch --format='%(refname:short)')

            if ([string]::IsNullOrWhiteSpace($pWord)) {
                return $branchList;
            }

            $branchList | Select-String "$pWord"
        })]
        [string] $branch
    )

    git checkout $branch;
}

# for editing your PowerShell profile
Function Edit-Profile
{
    vim $profile
}

# for editing your Vim settings
Function Edit-Vimrc
{
    vim $home\_vimrc
}

Function Edit-Neovim
{
    vim $home\AppData/Local/nvim/init.vim
}

Function Edit-Nu
{
    vim $home\AppData\Roaming\nushell\nu\config\config.toml
}

Set-PSReadLineOption -EditMode vi
Set-PSReadlineKeyHandler -Chord Tab -Function Complete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineOption -ShowToolTips -BellStyle Visual



Invoke-Expression (&starship init powershell)