# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" # kubectl krew; plugin to manage other kubernetes plugins
export PATH="/home/lucas/.local/bin:$PATH"
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
export PATH="/usr/local/bin/migrate:$PATH"

export BROWSER="firefox"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git vi-mode nvm npm)

# Path to your oh-my-zsh installation.
export ZSH="/usr/share/oh-my-zsh"

source $ZSH/oh-my-zsh.sh

# The next line updates PATH for Netlify's Git Credential Helper.
test -f '/home/lucas/.config/netlify/helper/path.zsh.inc' && source '/home/lucas/.config/netlify/helper/path.zsh.inc'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/lucas/.bun/_bun" ] && source "/home/lucas/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# -- FZF -- 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# setup fzf keybindings and fuzzy completion
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# setup fzf key for fuzzy completion
source <(fzf --zsh)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendHistory


# tmuxifier
eval "$(tmuxifier init -)"
export EDITOR='nvim'
alias tmfy="tmuxifier s"

# -- use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Bat (better cat)
#alias bat="batcat"

# Eza (better ls)
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions -a"
# (Old) ls
alias ols="ls"

# thef*ck
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# zoxide (better cd)
eval "$(zoxide init zsh)"
alias cd="z"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

export PATH=$PATH:/home/lucas/.spicetify

# Get ceiling eg: 7/2 = 4
ceiling_divide() {
  ceiling_result=$((($1+$2-1)/$2))
}

clear_rows() {
  POS=$1
  # Insert Empty Rows to push & preserve the content of screen
  for i in {1..$((LINES-POS-1))}; echo
  # Move to POS, after clearing content from POS to end of screen
  tput cup $((POS-1)) 0
}

# Clear quarter
alias ptop='ceiling_divide $LINES 4; clear_rows $ceiling_result'
# Clear half
alias pmid='ceiling_divide $LINES 2; clear_rows $ceiling_result'
# Clear 3/4th
alias pdown='ceiling_divide $((3*LINES)) 4; clear_rows $ceiling_result'

eval "$(starship init zsh)"
neofetch
