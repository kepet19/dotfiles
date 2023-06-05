
def get_config_files [] {
    let config_path = ($nu.env-path | path parse).parent
    cd $config_path
    ls **/*.nu | get name
}

def config_edit [config_file?: string@get_config_files] {
    let config_path = ($nu.env-path | path parse).parent
    cd $config_path
    echo $config_file

    if $config_file != null {
        ^$env.EDITOR $config_file
    } else {
        ^$env.EDITOR
    }
}

export def tail [file_path: path] {
	pwsh -Command Get-Content -Wait $file_path
}
