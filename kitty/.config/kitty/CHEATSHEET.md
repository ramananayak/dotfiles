# Kitty Cheatsheet

Custom bindings defined in [`splits.conf`](./splits.conf).
Designed to replace tmux for local workflows on macOS.

> Tip: view this anytime with `bat ~/.config/kitty/CHEATSHEET.md` or `nvim ~/.config/kitty/CHEATSHEET.md`.

---

## Tabs (your projects)

| Action                           | Key               |
| -------------------------------- | ----------------- |
| New tab (in current dir)         | `cmd-t`           |
| **Rename tab** ← used constantly | `cmd-shift-i`     |
| Close tab                        | `cmd-w`           |
| Jump to tab 1–9                  | `cmd-1` … `cmd-9` |
| Next tab                         | `cmd-shift-]`     |
| Previous tab                     | `cmd-shift-[`     |
| Move tab right                   | `cmd-shift-.`     |
| Move tab left                    | `cmd-shift-,`     |

## Splits (panes / kitty "windows")

| Action                               | Key                                                       |
| ------------------------------------ | --------------------------------------------------------- |
| Vertical split                       | `cmd-d`                                                   |
| Horizontal split                     | `cmd-shift-d`                                             |
| Close pane                           | `cmd-shift-w`                                             |
| Rename pane                          | `cmd-alt-i`                                               |
| Navigate left/down/up/right          | `cmd-h` / `cmd-j` / `cmd-k` / `cmd-l`                     |
| Resize narrower/shorter/taller/wider | `cmd-ctrl-h` / `cmd-ctrl-j` / `cmd-ctrl-k` / `cmd-ctrl-l` |
| Reset size                           | `cmd-ctrl-0`                                              |
| Zoom toggle                          | `cmd-shift-z`                                             |
| Next layout                          | `cmd-shift-l`                                             |
| Swap to top                          | `cmd-shift-x`                                             |

## OS Windows (Work vs Personal)

| Action                | Key               |
| --------------------- | ----------------- |
| New OS window         | `cmd-n`           |
| Switch to OS window 1 | `` cmd-` ``       |
| Switch to OS window 2 | `` cmd-shift-` `` |
| Close OS window       | `cmd-shift-q`     |

## Hints (replaces tmux-fzf-url)

| Action           | Key           |
| ---------------- | ------------- |
| Open URL         | `cmd-shift-u` |
| Copy path        | `cmd-shift-p` |
| Copy hash        | `cmd-shift-y` |
| Copy line number | `cmd-shift-n` |

## Misc

| Action              | Key               |
| ------------------- | ----------------- |
| Reload config       | `cmd-shift-r`     |
| Edit config         | `cmd-,`           |
| Scrollback in pager | `cmd-shift-h`     |
| Copy / Paste        | `cmd-c` / `cmd-v` |

---

## Workflow recipes

### Work / Personal split

1. `cmd-n` once → second OS window for Personal
2. In each window: `cmd-t` per project, `cmd-shift-i` to rename
3. Switch between them: `` cmd-` `` / `` cmd-shift-` ``

### Quick project layout (editor + shell)

1. `cd ~/Projects/foo`
2. `cmd-t` → new tab in that dir, `cmd-shift-i` → name it "foo"
3. `nvim` in the main pane
4. `cmd-shift-d` → horizontal split for shell

### Reach for tmux when…

- You need a process to survive `cmd-q` or a kitty crash
- You want to detach from a long-running task and reattach later
- Otherwise, kitty native is enough

---

## Conflicts / gotchas

- `cmd-h` is normally "hide window" on macOS — kitty intercepts it. Use `cmd-m` to minimize.
- `cmd-w` closes a tab, not the OS window. Use `cmd-shift-q` to close the whole window.
- `copy_on_select yes` auto-copies on mouse selection. Remove from `splits.conf` if undesired.
- Tab/window names do **not** persist across kitty restarts — that's a tmux-only feature.
