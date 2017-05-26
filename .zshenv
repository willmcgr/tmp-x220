##**************************************
##  file:     ~/.zshenv
##  author:   @willmcgr - will@willmcgr.tech
##  vim:fenc=utf-8:ft=zsh
##**************************************
##+NOTE: maybe clean this up a bit ...

##point zsh at ~/.zsh
ZDOTDIR="${ZDOTDIR:-${HOME}/.zsh}"

##  functions
  ##check if command exists
function hascmd(){ builtin hash $1 2>/dev/null | cut -d" " -f1 && return 0 || return 1 ;}
  ##check if package is installed
function haspkg(){ command pacman -Q $1 >/dev/null 2>&1 && return 0 || return 1 ;}

##  Add $HOME to cdpath/CDPATH
  ##CDPATH variable
#[[ $CDPATH =~ "${HOME}/usr" ]] && export CDPATH="$CDPATH::${HOME}"
  ##cdpath variable
#cdpath=( "${HOME}/usr" "${cdpath}" )
typeset -U cdpath

##  set various environment variables
  ##user directories
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
#export XDG_CONFIG_HOME="${HOME}/etc"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DESKTOP_DIR="/dev/null"
export XDG_DOCUMENTS_DIR="${HOME}/usr/docs"
export XDG_DOWNLOAD_DIR="${HOME}/usr/gets"
export XDG_MUSIC_DIR="${HOME}/usr/media/audio/music"
export XDG_PICTURES_DIR="${HOME}/usr/media/pictures"
export XDG_VIDEOS_DIR="${HOME}/usr/media/videos/camera"
export XDG_PUBLICSHARE_DIR="/dev/null"
export XDG_TEMPLATES_DIR="/dev/null"

  ##misc variables
export HOSTNAME="$(hostname)"
#export COLORTERM='yes'                                #fix iterm2 on mac osx
export DE='gnome'                                     #fix a few gui prgms i use

  ##GPG
export GPG_TTY="$(tty)"
#export GPGKEY=""
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export GPG_AGENT_INFO=x                               #needed for so mutt doesnt spaz out

  ##editor
export EDITOR="$(command -v vi) -p"
export FCEDIT="${EDITOR}"
export VISUAL="${EDITOR}"

  ##pager
export LESSHISTFILE="${XDG_CONFIG_HOME}/lesshst"
export LESSHISTSIZE=1000
export LESS="-imMJWRd"
export PAGER="$(command -v less) ${LESS}"
export SDVC_PAGER="${PAGER}"
export MANPAGER="${PAGER}"

  ##ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

  ##transmission
export TRANSMISSION_HOME="${XDG_CONFIG_HOME}/tranny"

  ##git
export GIT_EDITOR="${EDITOR}"
export GIT_PAGER="${PAGER}"
export GIT_AUTHOR_EMAIL="williammcgrath8@yahoo.com"
export GIT_COMMITTER_EMAIL="williammcgrath8@yahoo.com"

  ##sudo
export SUDO_EDITOR="$(command -v rvim) --noplugin"
export SUDO_PROMPT=$'\E[1;31;40m:: \E[1;36msudo  \E[1;31m>>\E[0m '
#export SUDO_PROMPT=$'\E[1;31;40m::  \E[1;36msudo\E[1;31m:\E[1;34m%p  \E[1;31m>>\E[0m '

  ##userspace
export BROWSER="$(command -v qutebrowser)"
export MOVPLAY="$(command -v mpv)"
export SNDPLAY="$(command -v mpv) --no-video"
export PICVIEW="$(command -v sxiv) -a"
export TERMINAL="$(command -v termite)"

  ##qt5 theming
export QT_QPA_PLATFORMTHEME='gtk2'

  ##systemd
export SYSTEMD_EDITOR="${EDITOR}"
export SYSTEMD_PAGER="$(command -v less) -j4aR"

  ##asp
export ASPROOT="${HOME}/src/.asp"

  ##color man pages in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;35m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;30;03;36m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;34m'


