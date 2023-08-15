$List = @(
[pscustomobject]@{name = "nushell"; isLocal = $false},
[pscustomobject]@{name = "nvim"; isLocal = $true}
)

foreach ($item in $list) {
        $name = $item.name
        $source = Resolve-Path("./*/*/${name}/")

	if ($item.isLocal) {
		$dest = $env:LOCALAPPDATA
	} else {
		$dest = $env:APPDATA
	}

        $dest = $(Join-Path -Path $dest -ChildPath $name)
        $dest
        $isValidPath = Test-Path $dest
        if ($isValidPath) {
            Write "Can't create junction ${name}"
            Get-Item $dest
        } else {
            Write "Creating junction link for ${name}"
            New-Item -ItemType Junction -Value $source -Path $dest
        }
}

    function Set-Dotfiles(
            [parameter(Mandatory=$true)] [string]$SourcePath, 
            [parameter(Mandatory=$true)] [string]$DestinationPath, 
            [switch]$Force
            )
{
    Get-Location
        $test = Resolve-Path($SourcePath)
        $test2= Resolve-Path($DestinationPath)
        $test
        $test2
        $Force
}
