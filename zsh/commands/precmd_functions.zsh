autoload -U add-zsh-hook

# adds functions to call before every command prompt is ready
# ensure precmd_functions is an array, then append to it
if [[ -z ${precmd_functions} ]]; then
    declare -a precmd_functions
fi
precmd_functions+=(
    "set-tab-title-by-host"
)

# add beta or gamma to terminal title
function set-tab-title-by-host() {

    local TAB_NAME

    # put the branch name in the terminal tab title if we have one
    if [[ -z ${GIT_BRANCH} ]]; then
        # path to current folder
        # replace home with ~
        TAB_NAME=${PWD//${HOME}/'~'}
    else
        # name of current git repo
        TAB_NAME=`git name`
    fi

    # set tab color to apollo's alpha stage #387a32
    echo -ne "\033]6;1;bg;*;default\a"
    echo -ne "\033]6;1;bg;red;brightness;56\a"
    echo -ne "\033]6;1;bg;green;brightness;122\a"
    echo -ne "\033]6;1;bg;blue;brightness;50\a"

    # if on an ssh connection, put the host in the title
    if [[ -n ${IS_BETA_HOST} ]];then
        TAB_NAME="BETA:${TAB_NAME}"
        # set tab to apollo's beta blue #4466ba
        echo -ne "\033]6;1;bg;red;brightness;68\a"
        echo -ne "\033]6;1;bg;green;brightness;102\a"
        echo -ne "\033]6;1;bg;blue;brightness;186\a"
    fi
    if [[ -n ${IS_GAMMA_HOST} ]];then
        TAB_NAME="GAMMA:${TAB_NAME}"
        # set tab to apollo's gamma purple #996699
        echo -ne "\033]6;1;bg;red;brightness;153\a"
        echo -ne "\033]6;1;bg;green;brightness;102\a"
        echo -ne "\033]6;1;bg;blue;brightness;153\a"
    fi
    set-tab-title ${TAB_NAME}
}