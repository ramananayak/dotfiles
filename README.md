# My dotfiles

managed with [GNU Stow](https://www.gnu.org/software/stow/)

Install with GNU stow

```bash

# stow directory: dotfiles
cd $HOME/dotfiles
stow -nv --dotfiles kitty tmux nvim git zsh 

```

Homebrew installation

```bash
# Leaving a machine
brew leaves > leaves.txt

# Fresh installation
xargs brew install < leaves.txt
```
