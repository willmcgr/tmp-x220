##**************************************
##  file:     ~/.zsh/.zprofile
##  author:   @willmcgr - will@willmcgr.tech
##  vim:fenc=utf-8:nu:ai:si:et:ts=4:sts=4:sw=4:ft=zsh:
##**************************************
##


##  default file permissions
umask 027

##  start mpd at login
if ! [[ -e "${HOME}/.mpd/mpd.pid" ]]
then
    if hascmd mpd
    then
        ( ( sleep 0.5s && command mpd ) & )
    fi
fi

##  Add user scripts to PATH
typeset -U path
[[ -d "${path}" ]] && path+=( ${HOME}/bin )

##  startx on tty1 and tmux on tty2
if [[ -z $DISPLAY ]] && (( XDG_VTNR == 1 ))
then
    exec startx -- vt1 -keeptty &>/dev/null
    logout
elif (( XDG_VTNR == 2 ))
then
    tmux attach-session -t secured || tmux new-session -s secured
fi


