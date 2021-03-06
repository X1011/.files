#! /usr/bin/env bash
# Test for an interactive shell.  There is no need to set anything past this point for scp and rcp, and it's important to refrain from outputting anything in those cases.
[[ $- != *i* ]] && return

source ~/.config/aliases.bash

export GOPATH=$HOME/.local/go
prepend_path() { [[ $PATH == *$1* ]] || PATH=$1:$PATH ;}
prepend_path $GOPATH/bin:$HOME/.local/apps/miniconda3/bin:$HOME/bin:$HOME/bin/vendor:node_modules/.bin

export VISUAL='gvim --nofork'
export EDITOR="$VISUAL"
export DIFFPROG=meld

export RCLONE_TRANSFERS=7
export RCLONE_FAST_LIST=true
export RCLONE_PROGRESS=true

export XZ_DEFAULTS=--verbose
export TS_ONFINISH=notify-send # Task Spooler: http://viric.name/soft/ts/
export LESS='--ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --quit-if-one-screen --no-init --tabs=4'
export TIGRC_USER=~/.config/tigrc
export GITHUB_USER=X1011
export CURL_HOME=~/.config

shopt -s autocd cdable_vars cdspell checkjobs dirspell extglob globstar histappend xpg_echo
HISTCONTROL=ignoredups
HISTSIZE=1000

# https://github.com/pindexis/marker
export MARKER_KEY_MARK='\em'
export MARKER_DATA_HOME=~/.config/marker
#export MARKER_HOME=
marker_sh="$MARKER_HOME/bin/marker.sh"
[[ -f $marker_sh ]] && source "$marker_sh"

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'
export LESS_TERMCAP_ue=$'\E[m'
#export LESS_TERMCAP_so=$'\E[38;5;246m'
#export LESS_TERMCAP_se=$'\E[0m'


# prompt

pwd-abbrev() {
    local pwdmaxlen=35

    local newPWD=`echo ${PWD} | sed "s|$HOME|~|"`
    if [ ${#newPWD} -gt $pwdmaxlen ]; then
        local pwdoffset=$(( ${#newPWD} - $pwdmaxlen ))
        newPWD="..${newPWD:$pwdoffset:$pwdmaxlen}"
    fi

    echo -n $newPWD
}

color_off=$'\e[m'

# regular colors
black='\e[0;30m'
red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
blue='\e[0;34m'
purple='\e[0;35m'
cyan='\e[0;36m'
white='\e[0;37m'

# bold
bblack='\e[1;30m'
bred='\e[1;31m'
bgreen='\e[1;32m'
byellow='\e[1;33m'
bblue='\e[1;34m'
bpurple='\e[1;35m'
bcyan=$'\e[1;36m'
bwhite='\e[1;37m'

git_prompt=/usr/lib/git-core/git-sh-prompt
if [[ -f $git_prompt ]]; then
	source "$git_prompt"
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWSTASHSTATE=true
	GIT_PS1_SHOWUNTRACKEDFILES=true
	GIT_PS1_SHOWCOLORHINTS=true
	GIT_PS1_SHOWUPSTREAM=verbose
	GIT_PS1_DESCRIBE_STYLE=branch

	PS1='`__git_ps1 "%s " | sed -e "s/master[ \|]\|u= //g"`\[$bcyan\]\$ \[$color_off\]'

	unset PROMPT_COMMAND
fi

title() {
	echo -ne "\e]2;"
	pwd-abbrev
	echo -n " \$ $BASH_COMMAND"
	echo -ne "\a"
}

# set the title now, with empty BASH_COMMAND
BASH_COMMAND= title

trap title DEBUG


# This file is sourced by all *interactive* bash shells on startup, including some apparently interactive shells such as scp and rcp that can't tolerate any output.  So make sure this doesn't display anything or bad things will happen!
