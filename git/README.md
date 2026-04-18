# Git config

Multiple accounts managed via directory-based `includeIf` in `~/.gitconfig`.

## Setup

| Directory                    | Identity                                        |
| ---------------------------- | ----------------------------------------------- |
| `~/Repositories/Work/Zynga/` | `rnayak@zynga.com` (via `.gitconfig-zynga`)     |
| everywhere else              | `65753883+ramananayak@users.noreply.github.com` |

## URL shorthands

| Shorthand      | Expands to                                   |
| -------------- | -------------------------------------------- |
| `gh:<repo>`    | `git@github.com:<repo>`                      |
| `my:<repo>`    | `git@github.com:ramananayak/<repo>`          |
| `zynga:<repo>` | `git@github-ca.corp.zynga.com:rnayak/<repo>` |
| `gst:<gist>`   | `git@gist.github.com:<gist>`                 |
