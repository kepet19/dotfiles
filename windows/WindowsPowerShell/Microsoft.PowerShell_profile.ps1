Function dev {Set-Location -Path ~/dev/}
Function mvc {Set-Location -Path ~/dev/mvc_dev/MVCPortal/MVCPortal/}
Function mvcd {Set-Location -Path ~/dev/ad-portal/}
Function adportal {Set-Location -Path ~/dev/adportalmodule/}
Function ser {Set-Location -Path ~/dev/server-portal/}
Function sql {Set-Location -Path ~/dev/sql-portal/}
Function fire {Set-Location -Path ~/dev/firewall-portal/}
Function pmain {Set-Location -Path ~/dev/main-portal/}
Function dotfiles {Set-Location -Path ~/dev/dotfiles}

if ($PSVersionTable.PSVersion.Major -le 5) {
    Del alias:curl
}
# Del alias:ls
# set-alias ls -Value lsd
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

Function Find-History { 
  $find = $args;
  Write-Host "Finding in full history using {`$_ -like `"*$find*`"}";
  Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -like "*$find*"} | Get-Unique | more
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

Function Edit-Starship
{
    nvim $home\.config\starship.toml
}

# for editing dot files
Function Edit-Dotfiles
{
    Set-Location ~/dev/dotfiles
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

function Open-Toolkit (
        [Parameter(Mandatory)]
        [string] $UnparsedTypeAndId
        )
{
    function parseTypeAndId ([string] $unparsedTypeAndId)
    {
        $id = $unparsedTypeAndId.Split('_')[0]

        if($id.StartsWith("W", 'CurrentCultureIgnoreCase'))
        {
            return $("WorkPackages", $id.SubString(1))
        }
        # Returns a tuple
        return $("Tasks", $id) # Return a tuple
    }

    if(!$UnparsedTypeAndId)
    {
        $UnparsedTypeAndId = git branch --show-current
        if (!$?)
        {
            throw "The command did not receive any input or it is not in any valid git repo"
        }
    }

    # Destructuring the tuple here
    $type, $id = parseTypeAndId($UnparsedTypeAndId)
    $link = "https://goto.netcompany.com/cases/GTO399/NCOBAD/Lists/$type/DispForm.aspx?ID=$id"

    Write-Output $link
    Start-Process $link
}

function Get-PublicTokenFromDll
{
    [CmdLetBinding()]
    [OutPutType([PSCustomObject])]
    param( 
    [Parameter(Mandatory)] 
    [string] $FilePath
    )
    ([system.reflection.assembly]::loadfile($FilePath)).FullName
}


Import-Module posh-git
$GitPromptSettings.EnableFileStatus = $false

Set-PSReadLineOption -EditMode vi
Set-PSReadlineKeyHandler -Chord Tab -Function Complete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineOption -ShowToolTips -BellStyle Visual
Set-PSReadLineKeyHandler -Chord Ctrl+o -ScriptBlock {
    lfcd
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('cls;')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('ls;')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

$env:path = "$env:userprofile\scoop\shims\;$env:path"

try {
    Invoke-Expression (&starship init powershell)
}
Catch {}
