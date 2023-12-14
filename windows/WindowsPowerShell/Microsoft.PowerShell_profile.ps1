$adServer = "nclan.netcompany.dk"

Function Mount-Ncop {
ssh -L 636:localhost:636 kkmp@ncop-ldpd-add01.dev.ldp.ncop.nchosting.dk -J kkmp@ssh.nchosting.dk
}
Function ldev
{Set-Location -Path "\\wsl$\Ubuntu\home\kkmp\dev\"
}
Function dev
{Set-Location -Path ~/dev/
}
Function mvc
{Set-Location -Path ~/dev/mvc_dev/MVCPortal/MVCPortal/
}
Function mvcd
{Set-Location -Path ~/dev/ad-portal/
}
Function adportal
{Set-Location -Path ~/dev/adportalmodule/
}
Function ser
{Set-Location -Path ~/dev/server-portal/
}
Function sql
{Set-Location -Path ~/dev/sql-portal/
}
Function fire
{Set-Location -Path ~/dev/firewall-portal/
}
Function pmain
{Set-Location -Path ~/dev/main-portal/
}
Function dotfiles
{Set-Location -Path ~/dev/dotfiles
}

# Active Direcotry stuff
Function GAR([string] $name)
{Get-ADGroup -Properties Members $name -Server $adServer
}
Function GAM([string] $name)
{Get-ADGroup -Properties MemberOf $name -Server $adServer
}
Function UM([string] $name)
{Get-ADUser -Properties MemberOf $name -Server $adServer
}

Function U {
   param(
       [Parameter(Position=0)]
       [string]$Identity,
       [string]$Filter
   )
   $parameters = @{
       'Server' = $adServer
       'Properties' = 'EmailAddress',
                       'WhenChanged',
                       'WhenCreated',
                       'ObjectGuid',
                       'OfficePhone',
                       'Company',
                       'Office',
                       'Department',
                       'Title',
                       'Description'
   }

   if ($Identity) {
       $parameters['Identity'] = $Identity
   }

   if ($Filter) {
       $parameters['Filter'] = $Filter
   }

   Get-ADUser @parameters
}


Set-Alias G Get-ADGroup


if ($PSVersionTable.PSVersion.Major -le 5)
{
    Remove-Item alias:curl
}

if ($alias:mv)
{
    Remove-Item alias:mv
}

if ($alias:rm)
{
    Remove-Item alias:rm
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

                if ([string]::IsNullOrWhiteSpace($pWord))
                {
                    return $branchList;
                }

                $branchList | Select-String "$pWord"
            })]
        [string] $branch
    )

    git checkout $branch;
}

Function Repair-WSLNetwork
{
    Get-NetAdapter | Where-Object {$_.InterfaceDescription -Like 'Cisco AnyConnect*'} | Set-NetIPInterface -InterfaceMetric 6000
}

Function Find-History
{
    $find = $args;
    Write-Host "Finding in full history using {`$_ -like `"*$find*`"}";
    Get-Content (Get-PSReadlineOption).HistorySavePath | Where-Object {$_ -like "*$find*"} | Get-Unique | more
}

Function New-Shortcut
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [System.IO.FileInfo]$Source,
        [string]$Arguments,
        [Parameter(Mandatory)]
        [System.IO.FileInfo]$DestinationPath
    )

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($DestinationPath.FullName)
    $Shortcut.TargetPath = $Source.FullName
    if ($Arguments)
    {
        $Shortcut.Arguments = $Arguments
    }
    $Shortcut.Save()
}

# For editing Microsoft SQL alias and stuff
Function Edit-SQL-Alias
{
    C:\Windows\SysWOW64\SQLServerManager15.msc
}

# for editing your PowerShell profile
Function Edit-Profile
{
    nvim $PROFILE
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


function Add-DeployAccount
{
    [CmdletBinding()]
    param ()

    Write-Host (Get-Location)
    $null = Read-Host "Press enter if the above location is correct else Ctrl+C"

    $cred = Get-Credential -UserName "deployAccount"

    $passwordBytes = [System.Text.Encoding]::Unicode.GetBytes($cred.GetNetworkCredential().Password)
    $encryptedPassword = [System.Security.Cryptography.ProtectedData]::Protect($passwordBytes, $null, [System.Security.Cryptography.DataProtectionScope]::CurrentUser)

    New-Item -Type Directory DeployAccounts\ -ErrorAction Ignore

    Set-Content DeployAccounts\B5C41083-67F7-4A27-AFCB-8E7CC64D35A1 -AsByteStream -Value $encryptedPassword
    Set-Content DeployAccounts\1A5A14D6-67ED-4543-95E5-1D55CEBB9C7B -AsByteStream -Value $encryptedPassword
}


Enum Scope {
    CurrentUser
    Machine
}

Function Get-PasswordCrypt
{
    [CmdletBinding()]
        param (
                [Scope]$Scope
              )
        $securePassword = Read-Host -Prompt "Enter your password" -AsSecureString
        Add-Type -AssemblyName System.Security

        switch($scope) {
                Scope::Machine {
                    $Scope = [System.Security.Cryptography.DataProtectionScope]::LocalMachine
                }
                Scope::CurrentUser {
                    $Scope = [System.Security.Cryptography.DataProtectionScope]::CurrentUser
                }
                Default {
                    $Scope = [System.Security.Cryptography.DataProtectionScope]::CurrentUser
                }
            }

    $password = [System.Net.NetworkCredential]::new("", $securePassword).Password
    $passwordBytes = [System.Text.Encoding]::Unicode.GetBytes($password)
    $encryptedPassword = [System.Security.Cryptography.ProtectedData]::Protect($passwordBytes, $null, $Scope)
    $base64Password = [System.Convert]::ToBase64String($encryptedPassword)

    $base64Password
}

function Add-PasswordFile
{
    [CmdletBinding()]
        param (
                [parameter(mandatory=$true)][string]$file,
                [Scope]$Scope
              )
        $securePassword = Read-Host -Prompt "Enter your password" -AsSecureString
        Add-Type -AssemblyName System.Security

        switch($Scope) {
                Scope::Machine {
                    $Scope = [System.Security.Cryptography.DataProtectionScope]::LocalMachine
                }
                Scope::CurrentUser {
                    $Scope = [System.Security.Cryptography.DataProtectionScope]::CurrentUser
                }
                Default {
                    $Scope = [System.Security.Cryptography.DataProtectionScope]::CurrentUser
                }
            }

    $password = [System.Net.NetworkCredential]::new("", $securePassword).Password
    $passwordBytes = [System.Text.Encoding]::Unicode.GetBytes($password)
    $encryptedPassword = [System.Security.Cryptography.ProtectedData]::Protect($passwordBytes, $null, $Scope)

    Set-Content $file -Value $encryptedPassword -Encoding Byte
}

Function EncryptPasswordTo-Base64 {
    $password = Read-Host -Prompt "Enter your password" -AsSecureString
    $encryptedPassword = $password | ConvertFrom-SecureString

    $encryptedBytes = [System.Text.Encoding]::Unicode.GetBytes($encryptedPassword)
    $base64Encoded = [Convert]::ToBase64String($encryptedBytes)

    $base64Encoded
}


function Get-PublicTokenFromDll
{
    [CmdLetBinding()]
    [OutPutType([PSCustomObject])]
    param(
        [Parameter(Mandatory)]
        [string] $Path
    )
    $file = Get-Item -Path $Path
    $fullPath = $file.VersionInfo.FileName
    Write-Output $fullPath

    ([system.reflection.assembly]::loadfile($fullPath)).FullName
}

function Get-PublicTokenFromDll1
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

try
{
    Invoke-Expression (&starship init powershell)
} Catch
{
}

