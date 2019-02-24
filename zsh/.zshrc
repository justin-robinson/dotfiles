# the full path to the directory this .zshrc file lives in
THIS_DIRECTORY=${0:a:h}

ZSH_DISABLE_COMPFIX="true"

export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# delete key to actually delete instead of printed a tilde
bindkey "^[[3~" delete-char

for f in ${THIS_DIRECTORY}/profile.d.zsh/*; do source $f; done

# load all commands
for f in ${THIS_DIRECTORY}/commands/*; do source ${f}; done

# setup tab completion for custom commands
fpath=(${THIS_DIRECTORY}/completions ${fpath})

autoload -Uz compinit
compinit -u

# check if oh-my-zsh is installed
if ! [[ -d ${HOME}/.oh-my-zsh ]];then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# heavily git focused theme
if [[ -z ${ZSH_THEME} ]]; then
    ZSH_THEME_GIT_PROMPT_CONFLICTS="%F{red}✖"
    ZSH_THEME="bullet-train"
    BULLETTRAIN_GIT_DIRTY=""
    BULLETTRAIN_GIT_CLEAN="%F{green}✔"
    BULLETTRAIN_GIT_ADDED="%F{green}✚"
    BULLETTRAIN_GIT_MODIFIED="%F{yellow}✹"
    BULLETTRAIN_GIT_UNTRACKED="%F{magenta}…"
    BULLETTRAIN_GIT_AHEAD="%F{green}⬆"
    BULLETTRAIN_GIT_BEHIND="%F{red}⬇"
    BULLETTRAIN_GIT_EXTENDED=false
    BULLETTRAIN_PROMPT_ORDER=(
        time
        dir
        screen
        git
        cmd_exec_time
    )
fi


# load oh my zsh custom plugins, themes, etc
ZSH_CUSTOM=${THIS_DIRECTORY}/oh_my_zsh_custom

# disable oh-my-zsh terminal title
export DISABLE_AUTO_TITLE="true"
# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh
source ${ZSH}/oh-my-zsh.sh
