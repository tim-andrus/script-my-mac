#!/usr/bin/env bash

# i miss opening folders like this from the mac
alias open="explorer.exe $1"

# can't use --git on wsl version of exa
alias ls='exa -l --group-directories-first --color=auto --icons --no-permissions --no-user'
alias ll='exa -lahF --group-directories-first --color=auto --icons'

# bat is installed as batcat on wsl/ubuntu
alias cat="batcat --paging=never"

# paths are in different locations on wsl. you have to look in the local users windows directory that is mounted
function ch() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

   if [ -d "/mnt/c/Users/$(whoami)/AppData/local/google/chrome/User Data/Default" ]; then
    google_history="/mnt/c/Users/$(whoami)/AppData/local/google/chrome/User Data/Default/History"
 else
    google_history="/mnt/c/Users/$(whoami)/AppData/local/google/chrome/User Data/Profile 1/History"
 fi
  open=xdg-open

  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}