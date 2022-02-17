# start-process {powershell -Command {New-item -ItemType SymbolicLink -Path "$env:Appdata/AppData/Local/nvim" -Target "./nvim/.config/nvim"}} -verb runAs
# start-process -verb runAs powershell -ArgumentList {New-item -ItemType SymbolicLink -Path "~/AppData/Local/nvim" -Target "./nvim/.config/nvim"}

# start-process -verb runAs powershell 'new-item -ItemType SymbolicLink -Path "~/AppData/Local/nvim" -Target "./nvim/.config/nvim"'

# start-process -verb runAs -FilePath powershell -ArgumentList ["$Host.UI.RawUI.ReadKey(\"NoEcho,IncludeKeyDown\")"]
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
	$arguments = "& '" +{New-item -ItemType SymbolicLink -Path "$env:Appdata/AppData/Local/nvim" -Target "./nvim/.config/nvim"} + "'"
		Start-Process powershell -Verb runAs -PassThru -Wait -ArgumentList $arguments
		Break

}

# New-Item -ItemType SymbolicLink -Path "C:\Users\kkmp\Documents\WindowsPowerShell\" -Target "C:\Users\kkmp\dev\dotfiles\windows\WindowsPowerShell\"

# PowerShell -Command {Get-EventLog -LogName security}
# PowerShell -Command "& {Get-EventLog -LogName security}"
