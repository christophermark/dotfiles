# AI / Claude Code Dotfiles

Configuration and scripts for Claude Code.

## Files

### `statusline-command.sh`

A custom two-line status bar for Claude Code that displays:

- **Line 1:** Model name, git branch with staged/unstaged/untracked file counts, and session cost
- **Line 2:** Context window usage bar (color-coded green/yellow/red) with percentage, and current directory

#### Installation

1. Copy or symlink the script:

   ```sh
   ln -sf "$(pwd)/ai/statusline-command.sh" ~/.claude/statusline-command.sh
   ```

2. Add to `~/.claude/settings.json`:

   ```json
   {
     "statusLine": {
       "type": "command",
       "command": "bash ~/.claude/statusline-command.sh"
     }
   }
   ```

3. Restart Claude Code. The status bar appears at the bottom of the terminal.

### `claude-code-setup-guide.md`

Recommended plugins and MCP server integrations for Claude Code, including GitHub, Context7, TypeScript LSP, and Example Skills.
