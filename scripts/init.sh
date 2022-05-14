#!/bin/bash

#############
# FUNCTIONS #
#############
function print_header {
    echo -e ''$_{1..30}'\b=';
    echo $1;
    echo -e ''$_{1..30}'\b=';
}

# move to project root
project_root=$(dirname $(dirname $(realpath $0)));
cd $project_root;

##########
# POETRY #
##########
print_header "Initialise poetry";
cd src;
poetry install;
cd $project_root;
echo "";

#######
# GIT #
#######
print_header "Config git";
git config --local include.path .gitconfig;
echo "";

##########
# VSCODE #
##########
print_header "Config vscode";
code --install-extension docsmsft.docs-markdown
code --install-extension eamodio.gitlens
code --install-extension Gruntfuggly.todo-tree
code --install-extension mikestead.dotenv
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode-remote.remote-ssh-edit
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension ms-vscode-remote.vscode-remote-extensionpack
code --install-extension njpwerner.autodocstring
code --install-extension oderwat.indent-rainbow
code --install-extension sdras.night-owl
echo "";

exit 0;
