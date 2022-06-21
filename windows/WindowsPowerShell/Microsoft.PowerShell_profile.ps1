Function dev {Set-Location -Path ~/dev/}
Function mvc {Set-Location -Path ~/dev/mvc_dev/MVCPortal/MVCPortal/}
Function mvcd {Set-Location -Path ~/dev/mvc_deploy/MVCPortal/MVCPortal/}
Function ser {Set-Location -Path ~/dev/serverportal/ServerPortal/}
Function sql {Set-Location -Path ~/dev/sql/SQLAutomationProject/}
Function fire {Set-Location -Path ~/dev/firewall-portal/}
Function pmain {Set-Location -Path ~/dev/main-portal/MainPortalUI/}

$DOTNET_CLI_TELEMETRY_OPTOUT=1

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

# For editing Microsoft SQL alias and stuff
Function Edit-SQL-Alias
{
    C:\Windows\SysWOW64\SQLServerManager15.msc
}

# for editing your PowerShell profile
Function Edit-Profile
{
    nvim $profile
}

# for editing dot files
Function Edit-Dotfiles
{
    cd ~/dev/dotfiles
    neovide .
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

Import-Module posh-git
Set-PSReadLineOption -EditMode vi
Set-PSReadlineKeyHandler -Chord Tab -Function Complete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineOption -ShowToolTips -BellStyle Visual

try {
    Invoke-Expression (&starship init powershell)
}
Catch {}
