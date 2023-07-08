# assumes tmux is already installed
# TODO: check if .tmux folder exists

# install tmux tpm if not already exists
if [ ! -d .tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# install ohmyzsh if not already installed
if [ ! -d ~/.oh-my-zsh ]; then
  wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
  sh install.sh
fi


