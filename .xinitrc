#!/usr/bin/env zsh
##**************************************
##  file:     ~/.xinitrc
##  author:   @willmcgr - will@willmcgr.tech
##  vim:ft=zsh
##**************************************

##general init
function ginit(){
    ##das keyboard
    #enable restart x
    command setxkbmap -option terminate:ctrl_alt_bksp

    #caps lock is escape
    command setxkbmap -option caps:escape

    #load xmodmap
    command xmodmap "${HOME}/.xmodmap"

    ##more x11 shtuffs
    #load xresources
    command xrdb -load "${HOME}/.xresources"

    ##deafmouse
    #set cursor
    command xsetroot -cursor_name left_ptr &

    #hide cursor
    command unclutter -noevents -idle 0.5 &

    #disable tpad
    command synclient TouchpadOff=1
}

##host init
function hinit(){
    case "$(hostname)" in
        (x220)
            rkeys=()
            ;;
        (x200)
            rkeys=()
            ;;
        (t520)
            rkeys=()
            ;;
        (Amala)
            rkeys=()
            ;;
        (*)
            rkeys=()
            ;;
    esac
    #fix key repeaters
    if [[ ${#rkey[@]} != 0 ]]
    then
        for key in "${rkey[@]}"
        do
            command xset -r "${key}"
        done && unset key rkey
    fi
}

##Root user X11
function uroot(){
    #ginit
    ginit
    #get dims
    DATA="$(/usr/bin/xrandr | awk '/\<connected\>/{print $4}' | sed 's/+[0-9]+[0-9]//')"
    WIDTH="${DATA/x*/}"
    HIGHT="${DATA/*x/}"
    XOFFS=1
    YOFFS=2
    #start terminal
    exec /usr/bin/termite --geometry=${WIDTH}x${HIGHT}+${XOFFS}+${YOFFS}
}

##Non-root user X11
function uuser(){
    #
}


