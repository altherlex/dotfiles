#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=$(pwd)                  # dotfiles directory
olddir=~/dotfiles_old       # old dotfiles backup directory
files="bash_aliases bash_colors bash_exports bash_profile bashrc gemrc gitconfig irbrc"    # list of files/folders to symlink in homedir

##########
echo "I'll move your actual dotfiles to ~/dotfiles_old"
echo "After that, I'm going to make symlinks to ~/ of the dotfiles"

# create dotfiles_old in homedir
mkdir -p $olddir

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
  mv ~/.$file $olddir/ 2> /dev/null
  cp $dir/.$file ~/.$file 2> /dev/null
done
echo "Dotfiles done!"

# copy apps
ln -s $dir/apps/PickColor.app /Applications/PickColor.app

source ~/.bash_profile
