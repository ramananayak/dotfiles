# My dotfiles

managed with [GNU Stow](https://www.gnu.org/software/stow/)

## Installation

Install with GNU Stow by explicitly targeting your home directory (`~` or `$HOME`):

```bash
# Enter dotfiles directory
cd ~/Repositories/Personal/dotfiles

# dry run
stow -nv -t ~ nvim git zsh starship readline psql sqlite3 mysql

# execute (ignore pgcli, mycli, litecli)
stow -v -t ~ nvim git zsh starship readline psql sqlite3 mysql

# unstow
stow -D -t ~ zsh
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
# replace <backup-dir> with your target location
rsync -a $HOME/.cache/ <backup-dir>/
```

Software Lists

- [Firefox browser, with profiles](https://www.firefox.com/en-US/)
- [Linear Mouse](https://linearmouse.app/)
- [Rectangle - Move and resize windows in macOS using keyboard shortcuts](https://rectangleapp.com/)
- [Docker](https://www.docker.com/)
- [kind - local Kubernetes clusters](https://kind.sigs.k8s.io/)
- [Postman](https://www.postman.com/)
- [Hoppscotch - OpenSource API Client](https://hoppscotch.com/)
- [Obsidian - for notes](https://obsidian.md/)
- [Readest](https://readest.com/)
- [Syncthing - continuous file synchronization program](https://syncthing.net/)
- [llama.cpp](https://github.com/ggml-org/llama.cpp)
- [Superwhisper](https://superwhisper.com/)

