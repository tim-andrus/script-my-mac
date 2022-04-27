# Setup fzf
# ---------
if [[ ! "$PATH" == *fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$(brew --prefix fzf)/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(brew --prefix fzf)/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$(brew --prefix fzf)/shell/key-bindings.zsh"