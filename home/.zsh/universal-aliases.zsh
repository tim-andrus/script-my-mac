#!/usr/bin/env bash

alias ..='cd ..'
alias ...='cd ../..'

alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'
alias chmod='chmod -v'
alias chown='chown -v'

alias sudo='sudo -E '
alias zshreload="omz reload"

alias yui="yarn upgrade-interactive --latest"
alias dinfo="du -d 1 -h"
alias finfo="du -sh"
alias ff="rg --files --hidden | fzf"
alias grep="grep --color"
alias sgrep="grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS,node_modules}"
alias listp="lsof -i TCP"
alias rnm="rm -rf ./node_modules"
alias guuid="uuidgen | tr \"[A-Z]\" \"[a-z]\""
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias git-wthjh="git-what-the-hell-just-happened"

function gitchanged(){
    git diff $1~ $1
}

function gitsearch(){
echo "Searching for $1..."
 git log -S "${1}" --source --all
}

function zippass(){
zip -er "$1.zip" "$2"
}

function stealfolder(){
    sudo chown -R $(whoami) .
}

function killp(){
lsof -t -i tcp:$1 | xargs kill
}

function fd() {
  local dir
  dir=$(find ./ -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m --query="$1") &&
  cd "$dir"
}

function fe() {
  IFS=$'\n' files=($(rg --files --hidden | fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

function fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

function timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

gcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

gcob() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

gstash() {
  emulate -L sh  # fix
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    # mapfile -t out <<< "$out"  # fix
    out=( "${(@f)out}" )  # fix
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

# like normal z when used with arguments but displays an fzf prompt when used without
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}
