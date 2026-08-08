# CodeCompanion — features in my Neovim setup

## Keymaps

| Key          | Mode | What it does                                                                                 |
| ------------ | ---- | -------------------------------------------------------------------------------------------- |
| `<leader>aa` | n, v | **Inline action** — no sidebar; writes directly into the buffer with a diff to accept/reject |
| `<leader>ac` | n, v | Open chat sidebar                                                                            |
| `<leader>ai` | n, v | Add current selection to the open chat                                                       |
| `<leader>at` | n    | Toggle chat sidebar open/closed                                                              |
| `<leader>am` | n    | Action palette — browse all built-in prompts via fzf                                         |

## Inside the chat buffer

| Key         | What it does                               |
| ----------- | ------------------------------------------ |
| `<CR>`      | Send message                               |
| `q`         | Close chat                                 |
| `ga`        | Accept a code change the LLM proposed      |
| `gr`        | Reject a code change                       |
| `gf`        | Jump to the file mentioned in the response |
| `[[` / `]]` | Jump between chat messages                 |
| `gd`        | Show debug info (raw request/response)     |

## Slash commands (type `/` in chat)

| Command     | What it does                                       |
| ----------- | -------------------------------------------------- |
| `/buffer`   | Add an open buffer to context (fzf picker)         |
| `/file`     | Add any file to context (fzf picker)               |
| `/terminal` | Paste the last terminal buffer output into context |
| `/compact`  | Summarise the conversation to save tokens          |
| `/fork`     | Branch the conversation from this point            |
| `/share`    | Export the chat                                    |

## `@` variables (type `@` in chat)

| Variable   | What it inserts  |
| ---------- | ---------------- |
| `@buffers` | All open buffers |
| `@editor`  | The current file |

## Action palette (`<leader>am`)

Built-in prompts browseable via fzf:

- Explain code
- Fix code / LSP diagnostics
- Generate tests
- Review code
- Commit message generation
- Documentation

## Inline mode (`<leader>aa`)

Select code in visual mode, hit `<leader>aa`, type a natural language instruction.
The LLM edits the buffer directly. A diff overlay shows what changed:

- `ga` to accept
- `gr` to reject

No sidebar involved. Lowest-friction interaction for single focused edits.

## Blink completions (inside chat buffer)

`/` and `@` autocomplete via blink.cmp — no need to type full command names.

## LSP integration

`gr` (references), `gd` (definition), `<leader>ca` (code actions) open in
fzf-lua fullscreen instead of the tiny quickfix float, via `register_ui_select()`.
