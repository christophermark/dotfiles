# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

############################################################

# PATH
# ADB and Android SDK tools
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="$HOME/Library/Android/sdk/build-tools/28.0.3:$PATH"
# Add Homebrew to the path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
# Add diff-so-fancy for pretty git diffs
# NOTE: Run this after to apply pretty git diffs:
# > git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
export PATH="$HOME/Library/diff-so-fancy:$PATH"
# Add python scripts to the path
export PATH="/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/bin:$PATH"
export PYTHONPATH="/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/bin:${PYTHONPATH}"

# Change the java version to explicitly use Java 7
export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_241`
export NDK_MODULE_PATH="$HOME/Library/Android/android-ndk-r21"
export ANDROID_NDK="$HOME/Library/Android/android-ndk-r21"

# Set the default editor (note: will set the ZLE to vi mode)
export EDITOR=vim
# Bring back the default ZLE mode, undoing the change to vi mode above
bindkey -e

########## Git Aliases ##########
# Delete any merged branches
alias mergedBranches="git branch --merged | egrep -v '(^\*|master|dev|release)'"
alias prBranches="git branch | egrep '^\s*pr-\d'"
alias deleteBranches="git branch | egrep '^\s*delete/'"
alias cleanBranches="{prBranches ; mergedBranches ; deleteBranches ;} | xargs git branch -D"
# Pull down latest changes and clean merged branches
alias update="git checkout develop && git pull -r upstream develop"
alias cleanup="update && cleanBranches"

# Checkout a PR branch from the `upstream` branch. Example: `pr 123` checks out PR 123
pr() {
  local UPSTREAM_BRANCH=${2:-upstream} # Optional argument for the upstream branch
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

# Hide yo secrets, hide yo wife
if [ -f ~/.secrets ]; then
  source ~/.secrets
fi

# Add Z functionality
. `brew --prefix`/etc/profile.d/z.sh

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

############################################################
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
