#! /usr/bin/env bash
# Test for an interactive shell.  There is no need to set anything past this point for scp and rcp, and it's important to refrain from outputting anything in those cases.
[[ $- != *i* ]] && return

me() { medit "$@" & }
alias rc="rclone --config=$HOME/.config/rclone.conf --drive-use-trash"
alias sym="ln -s"
alias tra=gvfs-trash
alias str="sudo gvfs-trash"

alias pa="sudo pacman"
alias prm="pa --remove --recursive --unneeded"
alias rm-orphans="prm `pa --query --quiet --unrequired --deps | xargs`"
alias pc=pacaur

alias pas="pa -S"
alias pcs="pacaur -S"
alias pps="sudo powerpill -S"
alias au="sudo aura -A"

alias syu="pa -Syu"
alias pu="pa -Su"
alias ppu="sudo powerpill -Su"
alias pcu="pacaur -Sau"

#alias git=git-achievements
alias g=git

alias clone="git clone"

alias s="git status --short"
alias d="git diff --word-diff=color"
alias dp="d HEAD^"
alias dpc="dp HEAD"
alias ds="git diff --stat"
alias ch="git checkout"
alias a="git add"
alias au="git add --update"
alias aa="git add --all"

alias lgb='git log --graph --abbrev-commit --pretty="format:%C(blue)%h%Creset %C(yellow)%d%Creset %s %Cgreen(%ad) %C(blue bold)%an%Creset"'
alias lg="lgb --branches HEAD"
alias l="lg -n 10"

ca() { git commit --verbose --all ${*:+--message="$*"}; }
alias ci="git commit --verbose"
alias n="git commit --verbose --amend"
alias na="git commit --verbose --amend --all"
alias st="git stash"

alias p="git push"
alias pl="git pull && l"
alias nb=new-branch
alias suo=set-upstream-origin

alias rb="git rebase"
alias rbi="git rebase origin -i"
alias rbc="git rebase --continue"
alias ra="git rebase --abort"
alias rs="git rebase --skip"

alias h="git help"
alias cg="git config --global"

alias o="less -x4"

alias i="ls --color=auto"
alias ii="i -l"
alias ia="i -a"
alias iia="i -la"
alias e=i
alias ee=ii
alias ea=ia
alias eea=iia

alias c=cd
alias u="cd .."
alias uu="cd ../.."
alias u3="cd ../../.."
alias pd=pushd
alias ppd=popd
mkcd() { mkdir -p "$@" && cd $1; }
mksud() { sudo mkdir -p "$@" && cd $1; }

alias tf="tail -f"

.() { source ${@:-~/.bashrc}; }
alias brc='$VISUAL ~/.bashrc && .'

set-upstream-origin() { git branch $1 --set-upstream origin; }
new-branch() {
	git checkout -b $1 $2 && \
	set-upstream-origin $1
}

prepend_path() { [[ $PATH == *$1* ]] || PATH=$1:$PATH; }

prepend_path ~/bin

export LESS="\
	--ignore-case \
	--LONG-PROMPT \
	--RAW-CONTROL-CHARS \
	--quit-if-one-screen \
	--no-init"

export EDITOR=vim
export VISUAL=medit
export DIFFPROG=meld

export GITHUB_USER=X1011

shopt -s autocd cdable_vars cdspell checkjobs dirspell extglob globstar histappend xpg_echo

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

source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUPSTREAM=verbose
GIT_PS1_DESCRIBE_STYLE=branch

PS1='`__git_ps1 "%s " | sed -e "s/master[ \|]\|u= //g"`\
\[$bcyan\]\$ \[$color_off\]'

unset PROMPT_COMMAND

title() {
	echo -ne "\e]2;"
	pwd-abbrev
	echo -n " $BASH_COMMAND"
	echo -ne "\a"
}
trap title DEBUG

source /usr/share/doc/pkgfile/command-not-found.bash

BASH_COMMAND= title


# This file is sourced by all *interactive* bash shells on startup, including some apparently interactive shells such as scp and rcp that can't tolerate any output.  So make sure this doesn't display anything or bad things will happen!
