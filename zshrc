# Path to your oh-my-zsh installation.
  export ZSH=/home/halushko/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"
# ZSH_THEME="bureau"

# ZSH_TMUX_AUTOSTART="true"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

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
plugins=(cp extract zsh-autosuggestions zsh-completions git fasd scala web-search svn-fast-info colored-man-pages colorize elixir asdf tmux)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

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
zstyle ':completion:*:processes' command 'NOCOLORS=1 ps -U $(whoami)|sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select
zstyle ':completion:*:processes-names' command 'NOCOLORS=1 ps xho command|sed "s/://g"'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'


prompt_svn() {
    local rev branch
    if in_svn; then
        rev=$(svn_get_rev_nr)
        branch=$(svn_get_branch_name)
        if [[ $(svn_dirty_choose_pwd 1 0) -eq 1 ]]; then
            prompt_segment yellow black
            echo -n "$rev@$branch"
            echo -n "±"
        else
            prompt_segment green black
            echo -n "$rev@$branch"
        fi
    fi
}

build_prompt() {
    RETVAL=$?
    prompt_status
    prompt_context
    prompt_dir
    prompt_git
    prompt_svn
    prompt_end
}

autoload -U compinit && compinit
ZSH_AUTOSUGGEST_USE_ASYNC="true"
zstyle ':completion:*' menu select
setopt complete_in_word

autoload -U zmv
setopt extended_glob

setopt correct
autoload -U colors && colors
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r?$reset_color (Yes, No, Abort, Edit) "

setopt menu_complete

setopt inc_append_history
setopt share_history

setopt auto_cd

autoload -U regexp-replace
setopt re_match_pcre

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

setopt NO_HUP
alias ll="ls -ll"
export SVN_EDITOR=vim
source ~/.profile
alias ccat="pygmentize -g"

# alias ec="emacs25 -nw"
# alias ew="emacs25"

# alias ec="/home/halushko/Projects/emacs-26.1-rc1/src/emacs-26.1.1 -nw"
# alias ew="/home/halushko/Projects/emacs-26.1-rc1/src/emacs-26.1.1"
# alias ec="/home/halushko/Projects/emacs-26.1/src/emacs-26.1.1 -nw"
# alias ew="/home/halushko/Projects/emacs-26.1/src/emacs-26.1.1"
# alias e="/home/halushko/Projects/emacs-26.1/lib-src/emacsclient"
alias ewt="/home/halushko/Projects/emacs/src/emacs"
alias ect="/home/halushko/Projects/emacs/src/emacs -nw"
alias ew="/opt/emacs-26.1/src/emacs"
alias ec="/opt/emacs-26.1/src/emacs -nw"
# alias ew="/home/halushko/Projects/emacs/src/emacs"
# alias e="/home/halushko/Projects/emacs/lib-src/emacsclient"
alias vf='vim $(fzf)'

# alias cew="emacsclient25"
# alias cec="emacsclient25 -nw"

alias h='history | grep '
emulate sh -c '. ~/.profile'

alias j='fasd_cd -d'     # cd, same functionality as j in autojump
alias jj='fasd_cd -d -i' # cd with interactive selection

# Bash-like navigation
autoload -U select-word-style
select-word-style bash

if [ -n "$INSIDE_EMACS" ]; then
    chpwd() { print -P "\033AnSiTc %d" }
    print -P "\033AnSiTu %n"
    print -P "\033AnSiTc %d"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
