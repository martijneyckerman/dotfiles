# Auto-launch tmux on terminal open (exec replaces this shell — no nesting)
if [[ -z "$TMUX" && $- == *i* ]]; then
  exec ~/.config/scripts/ghq-session.sh
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

source <(COMPLETE=zsh tms)
export EDITOR='nvim'
export PATH="$HOME/.cargo/bin:$PATH"

# ghq
export GHQ_ROOT="$HOME/Documents/repos"

# Route git clone through ghq so repos land in GHQ_ROOT/host/user/repo
git() {
  if [[ "$1" == "clone" ]]; then
    shift
    ghq get "$@"
  else
    command git "$@"
  fi
}

# cd into a ghq repo via fzf
ghqf() {
  local repo
  repo=$(ghq list | fzf --prompt "repo> " --height 40% --reverse --no-info)
  [[ -n "$repo" ]] && cd "$(ghq root)/$repo"
}

# ghq aliases
alias gf='ghqf'
alias gl='ghq list'
alias gg='ghq get'
alias gu='ghq get -u'

# tmux aliases
alias tl='tmux ls'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias tn='tmux new-session -s'

# General aliases
alias n='nvim'
alias s='paru -Ss'
alias i='paru -S'
alias r='paru -Rns'
alias u='paru -Syu'
alias ls='eza --icons=auto -l'

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

ZSH_THEME="powerlevel10k/powerlevel10k"

source ~/.oh-my-zsh/oh-my-zsh.sh

tmux-git-autofetch() {
    (/home/martijn/.config/tmux/plugins/tmux-git-autofetch/git-autofetch.tmux --current &)
}

add-zsh-hook chpwd tmux-git-autofetch

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/home/martijn/.bun/_bun" ] && source "/home/martijn/.bun/_bun"
