# Enable Starship
eval "$(starship init zsh)" 

# Add homebrew to the path
export PATH="/opt/homebrew/bin:/opt/homebrew/opt/libpq/bin:$PATH"

# Move history to .cache directory
# Zsh
export HISTFILE="$HOME/.cache/zsh/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
# psql
export PSQL_HISTORY="$HOME/.cache/psql/.psql_history"
# mycli
export MYCLI_HISTFILE="$HOME/.cache/mycli/.mycli-history"

# Zsh options for performance and usability
setopt HIST_IGNORE_DUPS     # Ignore duplicate commands in history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate

# Source other zsh configs
# My aliases
[[ -f $HOME/aliases.zsh ]] && source $HOME/aliases.zsh
# My exports
# [[ -f $HOME/exports.zsh ]] && source $HOME/exports.zsh
# Zynga (only load if exists)
[[ -f $HOME/zynga.zsh ]] && source $HOME/zynga.zsh

# Load Plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
