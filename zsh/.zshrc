# ============================================================================
# PATH Configuration
# ============================================================================
export PATH="/opt/homebrew/bin:/opt/homebrew/opt/libpq/bin:/opt/homebrew/opt/mysql-client/bin:$PATH"

# Prepend user-site Python bin if it exists (macOS ~/Library/Python/<version>/bin)
if [[ -d "$HOME/Library/Python" ]]; then
    _py_ver=$(ls -1 "$HOME/Library/Python" 2>/dev/null | sort -V | tail -1)
    [[ -n "$_py_ver" ]] && export PATH="$HOME/Library/Python/$_py_ver/bin:$PATH"
    unset _py_ver
fi

# ============================================================================
# Environment Variables
# ============================================================================
# History files in .cache directory
export HISTFILE="$HOME/.cache/zsh/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export MYSQL_HISTFILE="$HOME/.cache/mysql/.mysql_history"
export SQLITE_HISTORY="$HOME/.cache/sqlite/.sqlite_history"

# ============================================================================
# Zsh Options
# ============================================================================
setopt HIST_IGNORE_DUPS       # Ignore duplicate commands in history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate
setopt SHARE_HISTORY          # Share history across all sessions
setopt HIST_FIND_NO_DUPS      # Don't show duplicates in history search
setopt HIST_REDUCE_BLANKS     # Remove extra blanks from commands

# ============================================================================
# Source External Configs
# ============================================================================
[[ -f $HOME/.exports.zsh ]] && source $HOME/.exports.zsh
[[ -f $HOME/.aliases.zsh ]] && source $HOME/.aliases.zsh
[[ -f $HOME/.zynga.zsh ]] && source $HOME/.zynga.zsh

# ============================================================================
# Plugin Loading
# ============================================================================
BREW_PREFIX=/opt/homebrew
[[ -f $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ============================================================================
# Prompt Initialization
# ============================================================================
eval "$(starship init zsh)"

# ============================================================================
# Vi Keybindings (Vim Motions)
# ============================================================================
bindkey -v                    # Enable Vi mode in Zsh
export KEYTIMEOUT=1           # Reduce mode-switching delay to 10ms (default is 400ms)

# Custom cursor shape for Vi mode (Block cursor for Normal, Beam for Insert)
function zsh_cursor_vi_mode() {
    echo -ne "\e[2 q"         # Block cursor
}
function zsh_cursor_insert_mode() {
    echo -ne "\e[5 q"         # Beam/Line cursor
}

# Integrate with zsh line editor widgets to change cursor on mode switch
zle-keymap-select() {
    if [[ $KEYMAP == 'vicmd' ]]; then
        zsh_cursor_vi_mode
    else
        zsh_cursor_insert_mode
    fi
}
zle-line-init() {
    zle -K viins              # Always start in Insert mode
    zsh_cursor_insert_mode
}

zle -N zle-keymap-select
zle -N zle-line-init

# Fix backspace and delete behavior in Vi Insert mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line
