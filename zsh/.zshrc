# Enable Starship
eval "$(starship init zsh)" 

# Add homebrew to the path
export PATH="/opt/homebrew/bin:/opt/homebrew/opt/libpq/bin:$PATH"

# My aliases
[[ -f $HOME/.zsh_aliases ]] && source $HOME/.zsh_aliases

# My exports
# [[ -f $HOME/.zsh_exports ]] && source $HOME/.zsh_exports

# Zynga (only load if exists)
[[ -f $HOME/.zsh_zynga ]] && source $HOME/.zsh_zynga


# Load Plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
