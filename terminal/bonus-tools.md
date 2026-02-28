# iTerm2 Setup Guide — Bonus Tools, Shortcuts & Final Touches

---

## Bonus CLI Tools

These are the modern replacements for classic Unix tools that the community loves.

```bash
brew install fzf bat eza zoxide ripgrep fd tldr
```

| Tool               | Replaces       | Why it's great                                   |
| ------------------ | -------------- | ------------------------------------------------ |
| **fzf**            | Ctrl+R history | Fuzzy finder for files, history, anything        |
| **bat**            | `cat`          | Syntax-highlighted file viewer with line numbers |
| **eza**            | `ls`           | Modern `ls` with colors, icons, and git status   |
| **zoxide**         | `cd` / `z`     | Smarter directory jumping, learns from usage     |
| **ripgrep** (`rg`) | `grep`         | Blazingly fast search through files              |
| **fd**             | `find`         | Simpler, faster file finding                     |
| **tldr**           | `man`          | Community-driven simplified man pages            |

### Set up fzf keybindings

```bash
# After installing fzf, run its install script:
$(brew --prefix)/opt/fzf/install
```

This gives you `Ctrl+R` for fuzzy history search and `Ctrl+T` for fuzzy file search.

### Handy aliases to add to `~/.zshrc`

```bash
# Modern replacements
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias lt="eza --tree --level=2 --icons"
alias cat="bat --style=auto"

# Shortcuts
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
```

---

## Essential Keyboard Shortcuts

Master these and you'll fly through iTerm2:

| Shortcut          | Action                                |
| ----------------- | ------------------------------------- |
| `⌘ + D`           | Split pane horizontally               |
| `⌘ + ⇧ + D`       | Split pane vertically                 |
| `⌘ + [` / `⌘ + ]` | Switch between panes                  |
| `⌘ + T`           | New tab                               |
| `⌘ + W`           | Close tab/pane                        |
| `⌘ + ⇧ + Enter`   | Maximize/restore current pane         |
| `⌘ + /`           | Find cursor (highlights it when lost) |
| `⌘ + F`           | Search in terminal                    |
| `⌘ + ⌥ + E`       | Expose all tabs (bird's-eye view)     |
| `⌘ + ;`           | Autocomplete from history             |
| `⌘ + ⇧ + H`       | Paste history                         |

---

## Final Touches

### Shell integration (enables advanced features)

> **iTerm2 menu → Install Shell Integration**

This enables file downloads, drag-and-drop uploads, clickable file paths, and more.

### Set cursor to blinking bar

> **Profiles → Text → Cursor**: Choose **Vertical Bar** and check **Blinking cursor**

### Enable minimum contrast

> **Profiles → Colors → Minimum Contrast**: Set to ~20 to ensure text is always readable regardless of color scheme.

### Natural scrolling in `less`/`man`

Add to `~/.zshrc`:

```bash
export LESS='-R'
```

---

## Quick-Start Checklist

```
☐  Install Homebrew
☐  Install iTerm2
☐  Install MesloLGS Nerd Font and set it in iTerm2
☐  Import a color scheme (Catppuccin Mocha, Dracula, etc.)
☐  Set iTerm2 appearance to Minimal
☐  Silence the bell
☐  Enable Natural Text Editing key preset
☐  Install Oh My Zsh
☐  Install Powerlevel10k and run the config wizard
☐  Install zsh-autosuggestions, zsh-syntax-highlighting, you-should-use
☐  Enable plugins in .zshrc
☐  Install bonus CLI tools (fzf, bat, eza, zoxide, ripgrep)
☐  Add custom aliases
☐  Install Shell Integration
☐  Enjoy your new terminal ✨
```
