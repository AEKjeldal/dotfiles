#! /usr/bin/env bash

echo " I was run from: "
echo 
echo "Installing Vim Config"
echo "Linking Vimrc"
ln -rsf "${BASH_SOURCE%/*}/.vimrc" $HOME/.vimrc
echo "Linking vim folder"
ln -rsf "${BASH_SOURCE%/*}/.vi" $HOME/.vim
echo "Installing New Plugins"
vim +PluginUpdate +qall
echo "Vim config updated"






