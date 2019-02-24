function git_prompt_info () {
    set_git_vars
    # only run this if we are in a git branch
    if [[ -n ${GIT_BRANCH} ]]; then

        # our output will be enclosed in a square bracket
        local PROMPT_OUTPUT="${ZSH_THEME_GIT_PROMPT_PREFIX}${GIT_BRANCH}"

        if [[ -n ${GIT_REMOTE_BRANCH} ]]; then
            # number of commits ahead and behind remote
            local GIT_AHEAD="`git rev-list --left-right --count ${GIT_BRANCH}...${GIT_REMOTE_BRANCH} | cut -f1`"
            local GIT_BEHIND="`git rev-list --left-right --count ${GIT_BRANCH}...${GIT_REMOTE_BRANCH} | cut -f2`"
            if [[ ${GIT_AHEAD} -gt 0 ]]; then
                PROMPT_OUTPUT="${PROMPT_OUTPUT}${ZSH_THEME_GIT_PROMPT_AHEAD}${GIT_AHEAD}"
            fi
            if [[ ${GIT_BEHIND} -gt 0 ]]; then
                PROMPT_OUTPUT="${PROMPT_OUTPUT}${ZSH_THEME_GIT_PROMPT_BEHIND}${GIT_BEHIND}"
            fi
        fi

        # flag for determining if the git branch is in a clean state
        local GIT_IS_CLEAN=1

        # find number of files staged for commit
        local GIT_ADDED=`git diff --cached --numstat | wc -l | xargs`
        if [[ ${GIT_ADDED} -gt 0 ]]; then
            PROMPT_OUTPUT="${PROMPT_OUTPUT}${ZSH_THEME_GIT_PROMPT_ADDED}${GIT_ADDED}"
            GIT_IS_CLEAN=0
        fi

        # number of modified files
        local GIT_MODIFIED=`git diff --name-status --diff-filter=M | wc -l | xargs`
        if [[ ${GIT_MODIFIED} -gt 0 ]]; then
            PROMPT_OUTPUT="${PROMPT_OUTPUT}${ZSH_THEME_GIT_PROMPT_MODIFIED}${GIT_MODIFIED}"
            GIT_IS_CLEAN=0
        fi

        # number of files untracked by git
        local GIT_UNTRACKED=`git ls-files --exclude-standard --others | wc -l | xargs`
        if [[ ${GIT_UNTRACKED} -gt 0 ]]; then
            PROMPT_OUTPUT="${PROMPT_OUTPUT}${ZSH_THEME_GIT_PROMPT_UNTRACKED}${GIT_UNTRACKED}"
            GIT_IS_CLEAN=0
        fi

        # number of files in a conflicting state
        local GIT_CONFLICTS=`git diff --name-only --diff-filter=U | wc -l | xargs`
        if [[ ${GIT_CONFLICTS} -gt 0 ]]; then
            PROMPT_OUTPUT="${PROMPT_OUTPUT}${ZSH_THEME_GIT_PROMPT_CONFLICTS}${GIT_CONFLICTS}"
            GIT_IS_CLEAN=0
        fi

        # if there are no staged, modified, untracked, or conflicting files, we mark the repo as clean
        if [[ ${GIT_IS_CLEAN} -eq 1 ]]; then
            PROMPT_OUTPUT="${PROMPT_OUTPUT}${ZSH_THEME_GIT_PROMPT_CLEAN}"
        fi

        echo "${PROMPT_OUTPUT}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
    fi
}