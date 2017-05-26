##**************************************
##  file:     ~/.zsh/.zshrc
##  author:   @willmcgr - will@willmcgr.tech
##  vim:fenc=utf-8:ft=zsh
##**************************************
##

##  Interactive mode
[[ $- != *i* ]] && return

##  Disable flow control
  ##its time to stop
command stty ixoff
command stty -ixon
  ##set keys to nada
command stty start ''
command stty stop ''
  ##just in case
command stty ixany

##  Key mode
  ##vi keys
bindkey -v
  ##emacs keys
#bindkey -e
  ##key timeout for vi keys
KEYTIMEOUT=1

##  keep track of logins and long running commands
  ##report commands that last longer than a minute
REPORTTIME=5
  ##watch for users who are not me
WATCH="notme:root"
typeset -ga watch=( notme root )
  ##reporting format (see man zshall ; search WATCHFMT for details)
#WATCHFMT="%n has %a %l from %m"                               #default
WATCHFMT=$' \E[1;34m%n\E[0m has %a \E[0;36m%l\E[0m from \E[1;32m%m\E[0m at \E[0;33m%T\E[0m on \E[1;33m%D\E[0m. '
  ##time format (see man zshall ; search TIMEFMT for details)
TIMEFMT="%J  %U user %S system %P cpu %*E total"              #default

##  history options
  ##history files
HISTFILE="${ZDOTDIR:-${HOME}}/.zshhist"
HISTFILESIZE=65536
  ##history size
HISTSIZE=10000
SAVEHIST=$((HISTSIZE/2))

##  directory stack
  ##dirs to remember
DIRSTACKSIZE=20
  ##location of dir file
#DIRSTACKFILE="/tmp/.zsh_zdirs"
DIRSTACKFILE="${ZDOTDIR:-${HOME}}/.zdirs"

##  completion dump
  ##dump file
#COMPDUMPFILE="/tmp/.zsh_zcompdump"
COMPDUMPFILE="${ZDOTDIR:-${HOME}}/.zcompdump"

##  persistent history
  ##put frequent commands in here for conveinence
if [[ -r ${ZDOTDIR:-${HOME}}/.important_commands ]]
then
    builtin fc -R ${ZDOTDIR:-${HOME}}/.important_commands
fi

##  load host specific rc
  ##load local settings if they there
if [[ -r ${HOME}/.zshrc.local ]]
then
    builtin source ${HOME}/.zshrc.local
fi

##  grep options
  ##default grep colors
export GREP_COLOR="1;31"
GREP_COLORS="38;5;230"
  ##color whole selected line matches
GREP_COLORS+=":sl=38;5;240"
  ##color whole context line matches
GREP_COLORS+=":cx=38;5;100"
  ##color non-matching text in a matching line
GREP_COLORS+=":mt=38;5;161;1"
  ##color non-matching text in a context line
GREP_COLORS+=":ms=38;5;161;1"
  ##for file names prefixing content lines
GREP_COLORS+=":fn=38;5;197"
  ##for line numbers prefixing content lines
GREP_COLORS+=":ln=38;5;212"
  ##for byte offsets prefixing content line
GREP_COLORS+=":bn=38;5;44"
  ##for context separators
GREP_COLORS+=":se=38;5;166"
  ##export colors
export GREP_COLORS="${GREP_COLORS}"

  ##make options array
typeset -ga grep_options
if [[ "$(command uname -s)" == "Linux" ]]; then
    grep_options+=( --color=always )
fi

  ##add any local options to grep_options
#function grep_opts(){
#    local -a opts
#    local proj_opts="${PWD}/.grepoptions"
#    opts=( ${(f)"$(< "${HOME}/.grepoptions")"} )
#    if [[ -r ${proj_opts} ]] && [[ $PWD != $HOME ]];then
#        opts+=( ${${(f)"$(< "${proj_opts}")"}:#[#]*} )
#    fi
#    grep_options+=( ${(j: :)opts} )
#}

##  gcc options
  ##default gcc colors, names are self-explainatory
GCC_COLORS="error=01;31"
GCC_COLORS+=":warning=01;35"
GCC_COLORS+=":note=01;36"
GCC_COLORS+=":caret=01;32"

  ##location info
GCC_COLORS+=":locus=01"
GCC_COLORS+=":quote=01"

  ##export colors
export GCC_COLORS="${GCC_COLORS}"

##  ls options
  ##for colors; load dircolors config if its readable
if hascmd dircolors
then
    if [[ -r ${HOME}/.dircolors ]]; then
        eval $(command dircolors -b ${HOME}/.dircolors)
    else
        eval $(command dircolors -b)
    fi
fi

  ##make options array
typeset -ga ls_options
if [[ "$(command uname -s)" == "Linux" ]]; then
    ls_options+=( --color=always --group-directories-first -F )
fi

##  terminfo
  ##load terminfo if in home dir
if [[ -r ${HOME}/.terminfo ]]; then
    export TERMINFO=${HOME}/.terminfo
fi

##  autoload plugins
  ##colors
autoload -Uz colors && colors
  ##zmv (a better batched mv)
autoload -U zmv
  ##cli edit
autoload edit-command-line && zle -N edit-command-line


##**************************************
##  shell options
##**************************************

##  globbing options
  ##  *   see man 1 zshoptions for more info
setopt glob
setopt globcomplete
setopt extendedglob
setopt no_globdots
setopt globstarshort
setopt no_kshglob
setopt markdirs
setopt no_numericglobsort
#test with btrfs commands, might fix brace exansion issues
#setopt brace_ccl

##  history options
  ##  *   see man 1 zshoptions for more info
setopt append_history
setopt extendedhistory
setopt histallowclobber
setopt no_histbeep
setopt histexpiredupsfirst
setopt histignorealldups
setopt histignoredups
setopt histignorespace
setopt histsavenodups
unsetopt histverify
setopt no_histverify
unsetopt incappendhistory
setopt no_incappendhistory
setopt incappendhistorytime
setopt sharehistory

##  dirs stack options
  ##  *   see man 1 zshoptions for more info
setopt autopushd
setopt pushdignoredups
setopt pushdsilent
setopt pushdtohome

##  job control
  ##  *   see man 1 zshoptions for more info
setopt checkjobs
setopt no_hup
setopt longlistjobs
unsetopt notify
setopt no_notify

##  other misc options
  ##  *   see man 1 zshoptions for more info
setopt aliases
setopt autocd
setopt no_clobber
setopt correct
setopt no_correctall
setopt no_flowcontrol
setopt no_printexitvalue
setopt rmstarwait
setopt no_shwordsplit
setopt no_match
setopt chaselinks
setopt completealiases
setopt completeinword
unsetopt listbeep
setopt no_listbeep
setopt no_beep
#use to fix completions with dvorak
#setopt dvorak


##**************************************
##  completions
##**************************************
##+NOTE: clean this shit up ...

##  load basic completions
  ##load plugin
autoload -Uz compinit && compinit
  ##load modules
zmodload zsh/complist
  ##location of source file
zstyle :compinstall filename "${ZDOTDIR:-${HOME}/.zsh}/.zshrc"
  ##check modules
if (( ${+_comps} == 0 ));then
    print "\E[1;31;40m::  \E[1;36;40mzshrc\E[1;35;40m()\E[1;37;40m:\E[0m\t\E[1;31mERROR\E[1;37m:\tCompletions modules not properly loaded\E[0m"
fi

##  define extended completions
  ##completers to use
#zstyle ':completion:*::::'                        completer _expand _complete _ignored _approximate
#zstyle ':completion:*'                            expand prefix suffix
#zstyle ':completion:*'                            completer _expand_alias _complete _approximate
  ##use list colors (LS_COLORS)
#zstyle ':completion:*:defaults'                   list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*'                            list-colors ${(s.:.)LS_COLORS}
  ##tell _expand to insert a whitespace
#zstyle ':completion:*'                            add-space true
  ##tell _match and _approximate to insert if unambiguous matching is possible
#zstyle ':completion:*'                            insert-unambiguous true
  ##start menu completion if 2 or more matches exist
#zstyle ':completion:*'                            menu yes select=15
  ##verbose output
#zstyle ':completion:*'                            verbose yes
  ##ignore zsh internal functions
#zstyle ':completion:*:functions'                  ignored-patterns '_*'
  ##aliases tag colors
#zstyle ':completion:*:aliases'                    list-colors '=*=0;32'
  ##function tag colors
#zstyle ':completion:*:functions'                  list-colors '=*=0;31'
  ##group things by tags
#zstyle ':completion:*:matches'                    group 'yes'
#zstyle ':completion:*'                            group-name ''
  ##list of usernames to complete
#users=( will root )
  ##complete usernames
#zstyle ':completion:*'                            users $users
  ##processes
#zstyle ':completion:*:processes'                  command 'ps -au$USER'
  ##enable menu for [p]kill[all]
#zstyle ':completion:*:*:(pkill|kill|killall):*'   menu yes select
#zstyle ':completion:*:(pkill|kill|killall):*'     force-list always
  ##color output red[pids] and yellow[names] blue[all_else]
#zstyle ':completion:*:*:kill:*'                   list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'
  ##mpv completes dirs, audio, video files
#zstyle ':completion:*:*:mpv:*:*'                  file-patterns '*(.mp4|.avi|.mov) *(.mp3|.wav|.flac) *(-/)'
  ##pkg mgr completions
#zstyle ':completion:*:*:pacman:*'                 force-list always
#zstyle ':completion:*:*:pacman:*'                 menu yes select
  ##ignore l&f
#zstyle ':completion:*:cd:*'                       ignored-patterns '(*/)#lost+found' '(*/)#CVS'
  ##ignore used files in line
#zstyle ':completion:*:(rm|cp|mv|kill|diff|scp):*' ignore-line yes
  ##cd ignores parent dirs
#zstyle ':completion:*:cd:*'                       ignore-parents parent pwd
  ##dirs stack
#zstyle ':completion:*:*:cd:*:directory-stack'     menu yes select
  ##sort menu items by name
#zstyle ':completion:*'                            file-sort name
  ##sudo completes whats in $path
#zstyle ':completion:*:sudo:*'                     command-path $path
  ##man pages are better
#zstyle ':completion:*:manuals'    separate-sections true
#zstyle ':completion:*:manuals.*'  insert-sections   true
#zstyle ':completion:*:man:*'      menu yes select

##  formatting 
  ##default formatting
#zstyle ':completion:*'                  format '%B%d%b'
  ##warnings formatting
#zstyle ':completion:*:warnings'         format "%B$fg[red]%}no match for: $fg[white]%d%b"
  ##descriptions formatting
#zstyle ':completion:*:descriptions'     format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
  ##messages formatting
#zstyle ':completion:*:messages'         format '%B%U%d%u%b'
  ##corrections formatting
#zstyle ':completion:*:corrections'      format '%B%d (errors: %e)%b'


##**************************************
##  keybinding
##**************************************

##  Ctrl+h: run help
bindkey -M viins "" run-help
bindkey -M vicmd 'h'  run-help

##  Esc+v:  edit command in vi before executing...
bindkey -M vicmd "v" edit-command-line

##  Ctrl+r: history search
bindkey -M viins "" history-incremental-search-backward
bindkey -M vicmd "" history-incremental-search-backward

##  extend normal keys
  ##Ctrl+e: exit shell
bindkey "" Q
  ##Ctrl+p: change prompt
bindkey "" prtg
  ##Ctrl+l: clear screen
bindkey "" tmux-clear-screen

##  backspace: fix backspace issues
bindkey "" backward-delete-char

##  Ctrl+w: delete word backwards
bindkey "" backward-kill-word

##  fix terminal keys (readline replacement)
  ##esc key
bindkey -M viins ""       vi-cmd-mode
bindkey -M vicmd ""       vi-insert
  ##insert key
bindkey -M viins "[2~"    vi-cmd-mode
bindkey -M vicmd "[2~"    vi-insert
bindkey -M viins "[4h"    vi-cmd-mode
bindkey -M vicmd "[4h"    vi-insert
  ##delete key
bindkey "[3~"             delete-char
bindkey "[P"              delete-char
  ##home key
bindkey "[1~"             beginning-of-line
bindkey "[H"              beginning-of-line
bindkey "[OH"             beginning-of-line
bindkey "[7~"             beginning-of-line
  ##end key
bindkey "[4~"             end-of-line
bindkey "[F"              end-of-line
bindkey "[OF"             end-of-line
bindkey "[8~"             end-of-line
  ##pgup key
bindkey "[5~"             beginning-of-history
  ##pgdn key
bindkey "[6~"             end-of-history

##  vi keybinds
  ##undo typing
bindkey -M vicmd "u"  undo
  ##redo typing
bindkey -M vicmd "" redo

##  menu select binds (completion menu)
  ##enter runs the command
bindkey -M menuselect ''  .accept-line
  ##navigation
bindkey -M menuselect 'h'   vi-backward-char
bindkey -M menuselect 'k'   vi-up-line-or-history
bindkey -M menuselect 'l'   vi-forward-char
bindkey -M menuselect 'j'   vi-down-line-or-history


##**************************************
##  global aliases
##**************************************

##  for git/hg
  ##quick repository
alias -g UP="@{upstream}"
alias -g OUT="@{upstream}.."
alias -g IN="..@{upstream}"


##**************************************
##  suffix aliases
##**************************************

##  set text file extensions to $EDITOR
  ##define array
typeset -a exts=(
    asm awk
    c cfg coffee conf config cpp cs css csv
    diff
    env sps etx ex example
    git gitignore go
    h hs htm html
    info ini
    java jhtm js jsm json jsp
    lisp log lua
    map markdown md mf mfasl mi mkd mtx
    nfo
    pacnew patch pc pfa php pid PKGBUILD pl PL pm pod py
    rb rc rdf ru
    sed sfv signature sty sug
    t tcl tdy tex textile tfm tfnt theme txt
    urlview
    vim viminfo
    xml
    yml
)
  ##assign to $EDITOR
for ext in ${exts[@]}
do
    alias -s $ext="${EDITOR}"
done
builtin unset ext
  ##unset array
builtin unset exts

##  set audio file extensions to $SNDPLAY
  ##define array
typeset -a exts=(
    flac
    mp3
    oga
)
  ##assign to $SNDPLAY
for ext in ${exts[@]}
do
    alias -s $ext="${SNDPLAY}"
done
builtin unset ext
  ##unset array
builtin unset exts

##  set video file extensions to $MOVPLAY
  ##define array
typeset -a exts=(
    avi
    flv
    m4v mkv mp4 mov
    ogv
    wmv
)
  ##assign to $MOVPLAY
for ext in ${vido[@]}
do
    alias -s $ext="${MOVPLAY}"
done
builtin unset ext
  ##unset array
builtin unset exts

##  set pictures file extensions to $PICVEIW
  ##define array
typeset -a exts=(
    gif
    jpeg
    png
    svg
)
  ##assign to $PICVEIW
for ext in ${exts[@]}
do
    alias -s $ext="${PICVEIW}"
done
builtin unset ext
  ##unset array
builtin unset exts

##  set se file extension to ssh
for ext in se
do
    alias -s $ext="/usr/bin/ssh"
done
builtin unset ext


##**************************************
##  aliases
##**************************************
##+NOTE: clean this up ...

##  command shortcuts
  ##weather
alias WT-O="/usr/bin/curl 'http://wttr.in/Ocala'"
alias WT-S="/usr/bin/curl 'http://wttr.in/Southampton'"
  ##history
alias h=" history"
  ##zmv
alias zmv="noglob zmv"
  ##clear
alias C=" clear"
  ##exit
alias q=" Q"
alias qs=" exit"

##  cd family
  ##less typing, more like dos
alias cd..="cd .."
  ##navigate back n dirs
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias ...=".2"
alias ....=".3"
alias .....=".4"
alias ......=".5"
  ##vertical dirs stack list
alias dirs="dirs -v"

##  listing
  ##base ls
alias ls="command ls ${ls_options[@]}"
  ##vertical short list
alias lx="ls -1"
  ##shorten ll -> l
alias l=ll
  ##show hidden files also
alias la="ll -A"
  ##show only hidden files/dirs
#alias l.="ls -d .*(/) .*"
  ##vertical short list (hidden included)
#alias lxa="ls -1 -A"
  ##long list (hidden included)
#alias lxl="ls -1 -L"

##  add confirmations
  ##core utils
alias cp="command cp -i"
alias rm="command rm -I --preserve-root"
alias mv="command mv -i"
  ##ch*
alias chown="command chown --preserve-root"
alias chmod="command chmod --preserve-root"
alias chgrp="command chgrp --preserve-root"

##  assume recursive
  ##coreutils
alias cpr="cp -r"
alias rmr="rm -r"
  ##tree list
alias tree="command tree -C"
  ##short tree (default:2)
alias lt="tree -pL 2"
alias lt5="tree -pL 5"
  ##tree show hidden
alias lta="lt -a"

##  editor
  ##vi is vim
#alias vim=${EDITOR}
#alias cvim="command vim -p -N -u NONE"
#alias gvim="print \"${Bred}>>${Boff} Dont be a ${Bred}pussy${Bblk}.. ${Boff}use ${Bylw}vim${Bblk}...${Boff}\""
  ##sudo vi preserve env
#alias svi="command sudo -E vi"
  ##emacs is vi
#alias emacs=vi
#alias emacs="emacsclient -tty"
  ##vim splits
#alias vsp="vi -O"
#alias vsph="vi -o"

##  application aliases
  ##add default cfg to trc
#alias trc="command transmission-remote-cli -f ${TRANSMISSION_HOME:-${XDG_CONFIG_HOME:-${HOME}/.config}/transmission-daemon}/trcli.cfg"
  ##shorten transmission-remote
#alias trm="command transmission-remote"
  ##default options for wget
#alias wget="command wget -c --progress=bar:force:noscroll --show-progress --hgst-file=${XDG_CONFIG_HOME}/.wget-hsts"
  ##wget with minimal verbosity
#alias vget="wget --no-verbose"
  ##wget with no verbosity
#alias qget="wget --quiet"

##  system tools
  ##iptables list (include chain at end to see specific chain. ie: ipl INPUT to show INPUT chain)
alias ipl="command iptables -nv --line-numbers -L"
alias ip6l="command ip6tables -nv --line-numbers -L"
  ##systemd list units
#alias sdlu="command systemctl list-units"
  ##systemd list timers
#alias sdlt="command systemctl list-timers"
  ##shorthand for systemctl
#alias syctl="command systemctl"
  ##alias sudo to its command bin
#alias sudo="command sudo "

##  update settings
  ##zshrc
alias Z="builtin source ${ZDOTDIR:-${HOME}}/.zshrc"
  ##Xdefaults
alias X="command xrdb -load ${HOME}/.Xresources"
  ##i3wm
alias W="command i3-msg restart"


##**************************************
##  functions
##**************************************
##+NOTE: oh the places you'll go, the things you'll do ...


##**************************************
##  directory profiles
##**************************************

##  enable directory profiles
  ##  make function
function chpwd_profiles(){
    local profile context
    local -i reexecute
    context=":chpwd:profiles:$PWD"
    zstyle -s "$context" profile profile || profile='default'
    zstyle -T "$context" re-execute && reexecute=1 || reexecute=0
    if (( ${+parameters[CHPWD_PROFILE]} == 0 )); then
        typeset -g CHPWD_PROFILE
        local CHPWD_PROFILES_INIT=1
        (( ${+functions[chpwd_profiles_init]} )) && chpwd_profiles_init
    elif [[ $profile != $CHPWD_PROFILE ]]; then
        (( ${+functions[chpwd_leave_profile_$CHPWD_PROFILE]} )) \
            && chpwd_leave_profile_${CHPWD_PROFILE}
    fi
    if (( reexecute )) || [[ $profile != $CHPWD_PROFILE ]]; then
        (( ${+functions[chpwd_profile_$profile]} )) && chpwd_profile_${profile}
    fi
    CHPWD_PROFILE="${profile}"
    return 0
}
chpwd_functions=( ${chpwd_functions} chpwd_profiles )
  ##  turn off re execution in directory
zstyle ":chpwd:profiles:*" re-execute false
  ##  debugging
zstyle ":chpwd:profiles:*" debug true

##  profiles


##**************************************
##  startup init
##**************************************



