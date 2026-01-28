
### oh-my-zsh setup ###

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

plugins=(git z)

source $ZSH/oh-my-zsh.sh

############################################################

# PATH
# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
# CLI tools
export PATH="$HOME/.local/bin:$PATH"
# Add diff-so-fancy for pretty git diffs
# NOTE: Run this after to apply pretty git diffs:
# > git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
export PATH="$HOME/Library/diff-so-fancy:$PATH"
# Add Postgres to the path
export PATH="/opt/homebrew/opt/postgresql@14/bin:$PATH"
# Add python scripts to the path
export PATH="/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/bin:$PATH"
export PYTHONPATH="/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/bin:${PYTHONPATH}"

########## Android development ###########################################
# ADB and Android SDK tools
export PATH="$HOME/Library/Android/sdk:$PATH"
export ANDROID_HOME=$HOME/Library/Android/sdk
# Pin Java SDK to explicitly use Java 17 (best for Android)
# To install: `brew install --cask zulu@17`
if [ -d "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home" ]; then
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
elif /usr/libexec/java_home -v 17 >/dev/null 2>&1; then
  export JAVA_HOME="$(/usr/libexec/java_home -v 17)"
fi

# Maestro, if it exists
[ -d "$HOME/.maestro/bin" ] && export PATH="$PATH:$HOME/.maestro/bin"

# Set the default editor (note: will set the ZLE to vi mode)
export EDITOR=vim
# Bring back the default ZLE mode, undoing the change to vi mode above
bindkey -e

# Make Option+Left/Right jump words (they send ^[[1;3D / ^[[1;3C)
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

# (Optional) make Option+Backspace delete previous word
bindkey '^[^?' backward-kill-word

########## Git Aliases ###########################################

# Delete any merged branches
alias mergedBranches="git branch --merged | egrep -v '(^\*|master|dev|release)'"
alias prBranches="git branch | egrep '^\s*pr-\d'"
alias deleteBranches="git branch | egrep '^\s*delete/'"
alias cleanBranches="{prBranches ; mergedBranches ; deleteBranches ;} | xargs git branch -D"
# Pull down latest changes and clean merged branches
alias update="git checkout develop && git pull -r origin develop"
alias cleanup="update && cleanBranches"
# Prune merged branches
alias gone="git remote prune origin && git branch -vv | grep ': gone]' | awk '{print \$1}'"
alias pruneGone="gone | xargs git branch -D"

# Checkout a PR branch from the `origin` branch. Example: `pr 123` checks out PR 123
pr() {
  local UPSTREAM_BRANCH=${2:-origin} # Optional argument for the upstream branch
  command git fetch $UPSTREAM_BRANCH pull/$1/head:pr-$1 &&
    git checkout pr-$1
}

# Lists the branches most recently changed
alias branchlist="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' | less"
# Lists the most recently visited branches
# Example: `br 4` lists the 4 most recent branches
br() {
  local LINES_TO_OUTPUT=${1:-10} # Optional argument for number of lines to display
  command git reflog | grep checkout | grep -o -E 'to (.*)' | sed -e 's/to/  /' | sed -e '1s/   / ∗ /' | sed -e '1s/^/git branch history:\'$'\n/' | sed -e '1s/$/\'$'\n/' | awk ' !x[$0]++' | head -n $(($LINES_TO_OUTPUT+2))
}

# Fuzzy find git branch checkout
fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}
fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}

clone_and_start_maintenance() {
    # Background reading: https://www.alchemists.io/articles/git_maintenance
    if [ $# -ne 1 ]; then
        echo "Usage: clone_and_start_maintenance <repository_url>"
        return 1
    fi

    # Extract the repository name
    repo_name=$(echo "$1" | sed 's|.*/\([^/]*\)\.git$|\1|')

    # - Clone the repository
    # - Open the new repository
    # - Run `git maintenance start`
    git clone "$1" "$repo_name" && cd "$repo_name" && git maintenance start
}
alias gitclone='clone_and_start_maintenance'

########## Random Handy Aliases ##########

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

########## Mobile Development Aliases ##########

alias start:fresh="reset && npm run start -- --reset-cache"
alias reset="reset:npm && reset:watchman && reset:cache"
alias reset:cache="rm -rf $TMPDIR/metro-bundler-cache-* && rm -rf $TMPDIR/react-*"
alias reset:npm="rm -rf ./node_modules && npm install"
alias reset:watchman="watchman watch-del-all"
alias reset:pod="rm -rf ./ios/Pods && pod cache clean --all && pod install --project-directory=./ios/"

# Alias for the restarting React Native local server.
alias reverse="adb reverse tcp:8081 tcp:8081"
# Wake a connected Android device via the hardware button.
alias wake="adb shell input keyevent 82"
# Reload the React Native build
alias rr="adb shell input text 'RR'"

# Alias for common build commands
# Wake the connected Android device and open the Robin app
alias robin="adb shell input keyevent 82 && adb shell monkey -p com.robinpowered.compass -c android.intent.category.LAUNCHER 1"
# Aliases for building the Compass app.
# Note: `(C)` is used to capitalize the variant string
releaseVariants=(debug release releaseTest releaseTestDebuggable)
for variant in ${releaseVariants}; do
declare Variant=${(C)variant[1]}${variant[2,-1]} # Capitalized first letter: "debug" -> "Debug"
# Build the Compass app. Example: assembleRelease
alias assemble${Variant}="$HOME/dev/robin-compass/android/gradlew -p $HOME/dev/robin-compass/android/ assemble${Variant}"
# Install a built Compass app. Example: installRelease
alias install${Variant}="adb install -r $HOME/dev/robin-compass/android/app/build/outputs/apk/${variant}/app-${variant}.apk"
# Build, Install, Open the Compass app. Example: runRelease
alias run${Variant}="assemble${Variant} && install${Variant} && robin"
done
# Overwrite the debug config - it requires some extra steps
alias runDebug="assembleDebug && installDebug && reverse && robin"

#### General setup ##########################################

# Hide yo secrets
if [ -f ~/.secrets ]; then
  source ~/.secrets
fi

############################################################

# Map the numpad to work correctly. (only works for zsh emacs line editor mode)
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[On" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ol" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

# Set up NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Set up NVM to auto-load `nvm use` when it detects a `.nvmrc` file
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Rbenv
eval "$(rbenv init - zsh)"

alias gb='fzf-git-branch'
alias gco='fzf-git-checkout'
eval "$(/opt/homebrew/opt/rbenv/bin/rbenv init -)"
