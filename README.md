# My dotfiles

managed with [GNU Stow](https://www.gnu.org/software/stow/)

Install with GNU stow

```bash
# stow directory: dotfiles
cd $HOME/dotfiles
# dry run
stow -nv --dotfiles kitty tmux nvim git zsh

# execute
# ignore - pgcli , mycli, litecli (disabled)
stow -nv --dotfiles kitty tmux nvim git zsh

# unstow
stow -D zsh
```

Homebrew installation

```bash
# Leaving a machine
brew leaves > leaves.txt

# Fresh installation
xargs brew install < leaves.txt
```

Backup all history

```bash
cp $HOME/.cache
```

Software Lists
- [Firefox browser, with profiles](https://www.firefox.com/en-US/)
- [Linear Mouse](https://linearmouse.app/)
- [Docker](https://www.docker.com/)
- [Postman](https://www.postman.com/)
- [Requestly - Lightweight API Client](https://requestly.com/)
- [Obsidian - for notes](https://obsidian.md/)
- [Readest](https://readest.com/)
- [ollama](https://ollama.com/)
- [Superwhisper](https://superwhisper.com/)

