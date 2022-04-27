
#!/usr/bin/env bash

export JIRA_URL=https://www.atlassian.net
export JIRA_NAME="$(whoami)"
export JIRA_PREFIX=JIR-
export JIRA_RAPID_BOARD=false
export JIRA_DEFAULT_ACTION=dashboard

# disable zsh theme for pure prompt
export ZSH_THEME=""

# set default user for agnoster prompt
# export DEFAULT_USER="darraghoriordan"

# use ripgrep for fzf default command
export FZF_CTRL_T_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" --glob "!node_modules/*" --glob "!vendor/*" 2> /dev/null'

# use vscode as the default editor for everything
export EDITOR="code"
export GIT_EDITOR="code"
export VISUAL="code"

# disable oh my zsh updates
# export DISABLE_AUTO_UPDATE="true"
export UPDATE_ZSH_DAYS=13

# add paths if <commonly used thing> is installed
[[ -d "$HOME/development/flutter/bin" ]] && export PATH="$HOME/development/flutter/bin:$PATH"
[[ -d "/usr/local/opt/ruby/bin" ]] && export PATH="/usr/local/opt/ruby/bin:$PATH"
[[ -d "/opt/homebrew/opt/openjdk/bin" ]] && export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
[[ -d "$HOME/bin:/usr/local/bin" ]] && export PATH="$HOME/bin:/usr/local/bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion