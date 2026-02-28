# iTerm setup

### Appearance

- Appearance → General → Theme: Set to Minimal for a clean, modern look.
- Appearance → General: Uncheck _"Show per-pane title bar with split panes"_ for a cleaner layout.

### Profile Defaults

- Profiles → Window: Set columns/rows to taste (e.g., 120 x 35 is a good default).
- Profiles → Text → Font size: Bump to 14pt for readability.
- Profiles → Keys → Key Mappings → Presets: Enable Natural Text Editing preset (lets ⌥+← and ⌥+→ jump words, like in a text editor).

### Global Hotkey

- Keys → Hotkey → Create a Dedicated Hotkey Window: Set to ⌘ + ⌥ + I for instant terminal access from anywhere.

### Install a Nerd Font

Nerd Fonts are patched fonts that include icons used by themes like Powerlevel10k. The community overwhelmingly recommends MesloLGS NF.

```
brew install --cask font-meslo-lg-nerd-font
```

Then set it in iTerm2:

- Profiles → Text → Font → select "MesloLGS Nerd Font" or "MesloLGS NF"

### Pick a Color Scheme

The most popular community color schemes (all available at iterm2colorschemes.com):
| Scheme | Vibe |
|---|---|
| Catppuccin Mocha | Warm, pastel, easy on eyes (currently most hyped) |
| Dracula | Rich purple-based dark theme (longtime favorite) |
| Tokyo Night | Cool blue-toned dark theme |
| Solarized Dark | Classic muted dark with high readability |
| Gruvbox Dark | Retro warm earth tones |
| Nord | Cool arctic blue palette |
| One Dark | Port of the beloved Atom editor theme |

Then import:

- Profiles → Colors → Color Presets → Import… → select the .itermcolors file → then select it from the dropdown.
