#!/bin/bash
# https://github.com/nvm-sh/nvm#uninstalling--removal

rm -rf "${NVM_DIR}"

vim ~/.bashrc
# Edit ~/.bashrc (or other shell resource config) and remove the lines below:
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion
