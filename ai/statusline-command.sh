#!/usr/bin/env bash
# Claude Code status line — two lines
# Line 1: model name | git branch (staged/unstaged/untracked in yellow) | session cost
# Line 2: context bar (green/yellow/red) + percentage | last 2 path segments

input=$(cat)

# ── colours ──────────────────────────────────────────────────────────────────
RESET=$'\033[0m'
BOLD=$'\033[1m'
DIM=$'\033[2m'
YELLOW=$'\033[33m'
GREEN=$'\033[32m'
RED=$'\033[31m'
CYAN=$'\033[36m'
WHITE=$'\033[97m'

# ── LINE 1 ───────────────────────────────────────────────────────────────────

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')

# Git branch + file counts
branch=""
git_info=""
if git -C "$(echo "$input" | jq -r '.cwd // "."')" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  cwd_path=$(echo "$input" | jq -r '.cwd // "."')
  branch=$(git -C "$cwd_path" rev-parse --abbrev-ref HEAD 2>/dev/null)
  staged=$(git -C "$cwd_path" diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
  unstaged=$(git -C "$cwd_path" diff --name-only 2>/dev/null | wc -l | tr -d ' ')
  untracked=$(git -C "$cwd_path" ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
  counts=""
  [ "$staged" -gt 0 ]    && counts="${counts}${YELLOW}+${staged}${RESET} "
  [ "$unstaged" -gt 0 ]  && counts="${counts}${YELLOW}~${unstaged}${RESET} "
  [ "$untracked" -gt 0 ] && counts="${counts}${YELLOW}?${untracked}${RESET} "
  counts="${counts% }"  # trim trailing space
  if [ -n "$counts" ]; then
    git_info=" ${CYAN}${branch}${RESET} [${counts}]"
  else
    git_info=" ${CYAN}${branch}${RESET}"
  fi
fi

# Session cost
cost=$(echo "$input" | jq -r '
  if .cost.total_cost_usd != null then
    ("$" + (.cost.total_cost_usd | . * 1000 | round / 1000 | tostring))
  else
    ""
  end' 2>/dev/null)

# ── LINE 2 ───────────────────────────────────────────────────────────────────

# Context bar
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
  used_int=$(printf '%.0f' "$used_pct")
  bar_filled=$(( used_int / 5 ))   # 20 chars total
  bar_empty=$(( 20 - bar_filled ))
  if [ "$used_int" -lt 50 ]; then
    bar_color=$GREEN
  elif [ "$used_int" -lt 80 ]; then
    bar_color=$YELLOW
  else
    bar_color=$RED
  fi
  bar="${bar_color}"
  for i in $(seq 1 $bar_filled); do bar="${bar}█"; done
  bar="${bar}${DIM}"
  for i in $(seq 1 $bar_empty); do bar="${bar}░"; done
  bar="${bar}${RESET}"
  ctx_part="${bar} ${bar_color}${used_int}%${RESET}"
else
  ctx_part="${DIM}no context data${RESET}"
fi

# CWD — last 2 segments
cwd=$(echo "$input" | jq -r '.cwd // ""')
if [ -z "$cwd" ]; then
  cwd=$(pwd)
fi
short_cwd=$(echo "$cwd" | awk -F'/' '{
  n = NF
  if (n >= 2) print $(n-1) "/" $n
  else print $0
}')

# ── OUTPUT ───────────────────────────────────────────────────────────────────

sep="${DIM} │ ${RESET}"

line1="${WHITE}${BOLD}${model}${RESET}"
line1+="${git_info}"
[ -n "$cost" ] && line1+="${sep}${YELLOW}${cost}${RESET}"

line2="${ctx_part}${sep}${DIM}${short_cwd}${RESET}"

printf '%s\n%s\n' "$line1" "$line2"
