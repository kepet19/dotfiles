#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## browser : @adi1090x
## music : @adi1090x

rofi_command="rofi -location 1 -yoffset 30  -xoffset 5 -theme themes/apps.rasi"

# Links
terminal=""
files="ﱮ"
editor=""
browser=""
music=""
settings="漣"
virt=""

# Variable passed to rofi
options="$terminal\n$files\n$editor\n$browser\n$music\n$virt\n$settings"

chosen="$(echo -e "$options" | $rofi_command -p "Most Used" -dmenu -selected-row 0)"
case $chosen in
    $terminal)
        $TERMINAL &
        ;;
    $files)
        $FILE &
        ;;
    $editor)
        tau &
        ;;
    $browser)
        firefox &
        ;;
    $music)
	firefox "http://localhost:6680/musicbox_webclient/" &
        ;;
    $virt)
        virt-manager &
        ;;
    $settings)
        $TERMINAL -e configsettings &
        ;;
esac

