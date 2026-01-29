# My dotfiles

managed with [GNU Stow](https://www.gnu.org/software/stow/)

Install with GNU stow

```bash
# stow directory: dotfiles
cd $HOME/dotfiles
# dry run
stow -nv --dotfiles kitty tmux nvim git zsh

# execute
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
- [Obsidian - for notes](https://obsidian.md/)
- [Firefox browser, with profiles](https://www.firefox.com/en-US/)

