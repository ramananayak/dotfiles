command -v nvim >/dev/null && alias vim=nvim

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Shortcuts
alias cdo="cd ~/Downloads"
alias cde="cd ~/Desktop"
alias cpr="cd ~/Projects"
alias cre="cd ~/Repositories"

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# K8S
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs -f"
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias kc="kubectx"
alias kns="kubens"
alias ke="kubectl exec -it"
alias kcns='kubectl config set-context --current --namespace'

# Database
# Quick view of database command history
alias psql_log="tail -n 20 ~/.cache/psql/.psql_history"
alias mysql_log="tail -n 20 ~/.cache/mysql/.mysql_history"
alias sqlite_log="tail -n 20 ~/.cache/sqlite/.sqlite_history"

# Detect which `ls` flavor is in use (explicit OS check avoids ambiguity when coreutils is installed)
if [[ "$(uname)" == "Darwin" ]] && ! ls --color > /dev/null 2>&1; then # BSD `ls` on macOS
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
else # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# List all files colorized in long format
alias ll="ls -lF ${colorflag}"

# List all files colorized in long format, including dotfiles
alias la="ls -lAF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# Always enable colored `grep` output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Get week number
alias week='date +%V'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Cheatsheets
alias kcheat='nvim ~/.config/kitty/CHEATSHEET.md'

# Kitty terminal alias
alias icat="kitten icat"

# local llm usage
# Use local llm model with llama.cpp
alias qwen='llama-cli --hf-repo unsloth/Qwen3.5-9B-GGUF --hf-file Qwen3.5-9B-Q8_0.gguf --jinja --color auto -ngl 99 -fa auto -temp 0.7 --min-p 0.05 -c 40960 -n 32768 --no-context-shift'

# Llama Server Management
alias llama-start="llama-server --hf-repo unsloth/Qwen3.5-9B-GGUF --hf-file Qwen3.5-9B-Q8_0.gguf -ngl 99 -fa auto --temp 0.7 --min-p 0.05 -c 40960 --host 127.0.0.1 --port 8080 --ui-config '{\"systemMessage\":\"You are a highly efficient, precise AI assistant. Provide direct answers with minimal fluff. Always prioritize clarity, accuracy, and brevity. Use structured formatting or code blocks only when helpful.\"}' > /tmp/llama.log 2>&1 & echo 'Llama server started on http://127.0.0.1:8080'"
alias llama-start-agent="llama-server --hf-repo unsloth/Qwen3.5-9B-GGUF --hf-file Qwen3.5-9B-Q8_0.gguf -ngl 99 -fa auto --temp 0.7 --min-p 0.05 -c 40960 --host 127.0.0.1 --port 8080 --tools all --ui-config '{\"systemMessage\":\"You are a highly efficient, precise AI assistant. Provide direct answers with minimal fluff. Always prioritize clarity, accuracy, and brevity. Use structured formatting or code blocks only when helpful.\"}' > /tmp/llama.log 2>&1 & echo 'Llama agent server started with local file tools on http://127.0.0.1:8080'"
alias llama-stop="pkill -f llama-server && echo 'Llama server stopped'"
alias llama-status="ps aux | grep llama-server | grep -v grep"

# Git worktree: fuzzy-switch to a worktree of the current repo
gwt() {
	local wt
	wt=$(git worktree list | fzf --prompt="worktree> " | awk '{print $1}') && cd "$wt"
}
