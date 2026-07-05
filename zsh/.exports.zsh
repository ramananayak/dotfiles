# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Locale is left as system default (LANG / LC_*).

# export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="$(tput bold; tput setaf 3)";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less';

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty);

# Kubernetes
export KUBECONFIG=~/.kube/config

# Hide the “default interactive shell is now zsh” warning on macOS.
export BASH_SILENCE_DEPRECATION_WARNING=1;
