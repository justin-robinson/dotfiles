if ! type git >/dev/null 2>&1; then
    echo "git is not installed"
    return 0
fi

# shows your commits
git config --global alias.mine '!f() { git log --oneline --author=`whoami`; }; f'
# the current branch
git config --global alias.which 'rev-parse --abbrev-ref HEAD'
# delete local and remote branch
git config --global alias.delete '!f() { git branch -D $1; git push origin --delete $1; }; f'
# current repo name
git config --global alias.name '!f() { basename `git rev-parse --show-toplevel`; }; f'
# the remote repo name
git config --global alias.name-remote '!f() { git rev-parse --abbrev-ref --symbolic-full-name @{u}; }; f'


alias g='git '
alias gs='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gpp='git pull; git push'
alias gcl='git checkout $GIT_BRANCH_LAST'
alias gm='git mine'

####################
### GIT COMMANDS ###

# git push branch
function gpb(){
  git push --set-upstream origin ${GIT_BRANCH}
}

# commit and push
function cpush(){
  gcommit "${@}"
  gpb
}

# commit with branch name included
function gcommit(){
  local defaultBranch=`git symbolic-ref refs/remotes/origin/HEAD | awk -F / '{print $NF}'`
  # add branch to commit
  local message=""

  if [[ "${GIT_BRANCH}" != "${defaultBranch}" ]]; then
    message="[${GIT_BRANCH}] "
  fi

  # add passed commit message
  message="${message}${@}"

  git commit -m "${message}"
}

# add and commit
function ac(){
    git add .
    gcommit "${@}"
}

# add, commit, and push
function acp(){
  git add .
  cpush ${@}
}

# merge this branch with the last one we were in
function gml(){
  if [[ ! -z "${GIT_BRANCH_LAST}" ]]; then
    git merge ${GIT_BRANCH_LAST}
  fi
}

# list of commits that are mine
function gm(){
  if [[ ! -z "${1}" ]]; then
    git mine | grep ${1}
  else
    git mine
  fi
}

# commits that came from the last branch we were in
function gmlb(){
  gm ${GIT_BRANCH_LAST}
}

### GIT COMMANDS ###
####################


########################
### PRECMD_FUNCTIONS ###

autoload -U add-zsh-hook

# adds functions to call before every command prompt is ready
# ensure precmd_functions is an array, then append to it
if [[ -z ${precmd_functions} ]]; then
    declare -a precmd_functions
fi
precmd_functions+=(
    "set_git_vars"
)

# set GIT_BRANCH and other variables
function set_git_vars () {

    # keep track of current and last git branch
    local temp=${GIT_BRANCH}
    GIT_BRANCH=`git which 2>/dev/null`
    if [[ ${temp} != ${GIT_BRANCH} ]]; then
        GIT_BRANCH_LAST=${temp}
        GIT_REMOTE_BRANCH=`git name-remote 2>/dev/null`
    fi

    # put the branch name in the terminal tab title if we have one
    if [[ -z ${GIT_BRANCH} ]]; then
        unset GIT_BRANCH_LAST
        unset GIT_BRANCH
        unset GIT_REMOTE_BRANCH
    fi
}

### PRECMD_FUNCTIONS ###
########################
