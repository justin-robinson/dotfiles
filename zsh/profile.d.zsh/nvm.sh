export NVM_DIR="$HOME/.nvm"
# download nvm if it doesn't exist
if ! [[ -d ${NVM_DIR} ]];then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | zsh
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
