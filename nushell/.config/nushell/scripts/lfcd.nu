export def-env lfcd [...args: any] {
    let tmp = ([$nu.temp-path, $"lfcd-(random chars -l 5).tmp"] | path join)

    lf -last-dir-path $"($tmp)" $args

    let dir = (open $tmp)
    rm $tmp

    if $env.PWD != $dir {
        cd $dir
    }
}
