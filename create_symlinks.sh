if [ -L $HOME/.zshrc ]; then
  unlink $HOME/.zshrc
fi
ln -s $(pwd)/.zshrc $HOME/.zshrc

if [ -L $HOME/.tmux.conf ]; then
  unlink $HOME/.tmux.conf
fi
ln -s $HOME/.tmux.conf $HOME/.tmux.conf


if [ -L $HOME/.wezterm.lua ]; then
  unlink $HOME/.wezterm.lua
fi
ln -s $HOME/.wezterm.lua $HOME/.wezterm.lua
