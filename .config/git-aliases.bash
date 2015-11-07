#! /usr/bin/env bash

alias g=git
alias h='git help'
alias gc='git config'
alias cg='git config --global'

alias clone='git clone'
alias p='git push'
alias po='p origin'
alias pl='git pull && l'

alias ch='git checkout'
suo() {
    branch=${1:-$(git rev-parse --abbrev-ref HEAD)}
    git branch $branch --set-upstream-to origin/$branch
}
alias b='git branch'
alias reset='git reset'
alias rs1='reset HEAD^'

lgb() { git log --graph --abbrev-commit --pretty="\
%Cgreen%>>|(12,trunc)%ad\
%Creset %<(50,trunc)%s\
%C(yellow)%>>(14,trunc)%D \
%C(blue bold)%>>(9,trunc)%an \
%Creset%Cblue%h\
%Creset" "$@" |
sed -e 's/*/●/g;
        s/ ago//g'
#    -e 's|, origin/HEAD||'
}
alias lg='lgb --branches HEAD'
alias l='lg -n 7'

alias s='git status --short'
alias d='git diff --word-diff=color'
alias dp='d HEAD^'
alias dpc='dp HEAD'
alias do='d origin'
alias t='d --cached'
alias ds='git diff --stat'

alias a='git add'
alias au='git add --update'
alias aa='git add --all'

ca() { git commit --verbose --all ${*:+--message="$*"}; }
alias m='git commit --verbose'
alias mp='m --patch'
alias n=' m --amend'
alias np='n --patch'
alias na='n --all'
alias nn='n --no-edit'
alias nan='na --no-edit'

alias sta='git stash'
alias st='git stash save'
alias sp='git stash pop'

alias rb=' git rebase'
alias rbo='rb origin'
alias ri=' rb --interactive'
alias r3=' ri HEAD~3'
alias rbc='rb --continue'
alias ra=' rb --abort'
alias rs=' rb --skip'
