# Claude Code Plugins & MCP Setup Guide

Suggested plugins and MCP integrations for this project.

## Quick Start

**1. Add the plugin marketplaces** (one-time setup):

```
/plugin marketplace add anthropics/claude-plugins-official
/plugin marketplace add anthropics/skills
```

**2. Follow the install instructions** in the table below.

---

## Recommended MCPs and Plugins

| Plugin / MCP        | Install command                                                                                              | Description                                                                                                                                                                                  |
| ------------------- | ------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GitHub              | `/plugin install github@claude-plugins-official`                                                             | GitHub access. Requires `GITHUB_PERSONAL_ACCESS_TOKEN` env var with `repo` scope.                                                                                                            |
| Context7 MCP        | [Context7 MCP installation](https://github.com/upstash/context7?tab=readme-ov-file#installation)             | Recommended over the Claude plugin. Allows agents to look up public documentation. <br>⚠️ Add an API key from [context7.com/dashboard](https://context7.com/dashboard) to avoid rate limits. |
| TypeScript LSP      | `/plugin install typescript-lsp@claude-plugins-official`                                                     | Code intelligence for TypeScript/JavaScript.                                                                                                                                                 |
| Example Skills      | `/plugin install example-skills@anthropic-agent-skills`                                                      | Includes `/skill-creator` for authoring and editing project skills in `.agents/skills/`.                                                                                                     |
