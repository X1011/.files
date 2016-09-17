#! /usr/bin/env bash

alias g=git
alias h='git help'
alias gc='git config'
alias cg='git config --global'

alias clone='git clone'
alias p='git push'
alias po='p origin'
pl() { git pull "$@" && l; }
alias fe='git fetch'

alias b='git branch'
alias bv='git branch -vv'
suo() {
    local branch=${1:-$(git rev-parse --abbrev-ref HEAD)}
    git branch "$branch" --set-upstream-to "origin/$branch"
}

alias ch='git checkout'
alias co='git checkout origin'
alias reset='git reset'
alias rs1='reset HEAD^'

alias log='git log --word-diff=color'
alias lp='log --patch'
lgb() { git log --graph --abbrev-commit --word-diff=color --pretty="\
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
lg() { lgb --branches --remotes=origin "$@"; }
l() { lg -n 7 "$@"; }

alias s='git status --short'
alias d='git diff --word-diff=color'
alias dp='d HEAD^'
alias dpc='dp HEAD'
alias dor='d origin' #don't use 'do'; it's a reserved word
alias t='d --cached'
alias ds='git diff --stat'

alias a='git add'
alias au='git add --update'
alias aa='git add --all'
alias af='git add --force'

ca() { git commit --verbose --all ${*:+--message="$*"}; }
alias m='git commit --verbose'
alias mp='m --patch'
mm() { m --message="$*"; }
alias mma=ca
m1() { m "$1" --message="${*:2}"; }

alias n=' m --amend'
alias np='n --patch'
alias na='n --all'
nm() { n --message="$*"; }
alias nn='n --no-edit'
alias nan='na --no-edit'

alias st='git stash'
alias ss='git stash save'
alias sp='git stash pop'

alias rb=' git rebase'
alias rbo='rb origin'
alias ri=' rb --interactive'
alias r3=' ri HEAD~3'
alias r5=' ri HEAD~5'
alias rc='rb --continue'
alias ra=' rb --abort'
alias rs=' rb --skip'

alias mg='git merge'
alias ma='git merge --abort'
merge-master() {
    local branch=`git rev-parse --abbrev-ref HEAD`
    git checkout master
    git merge "$@" "$branch"
}
