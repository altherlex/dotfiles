#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=$(pwd)                  # dotfiles directory
olddir=~/dotfiles_old       # old dotfiles backup directory
files="bash_aliases bash_colors bash_exports bash_profile vimrc vim gemrc gitconfig irbrc"    # list of files/folders to symlink in homedir

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
cp $dir/apps/PickColor.app /Applications/PickColor.app

#--

#install c++ compiler
xcode-select --install

#install rvm 
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.bash_profile
source ~/.profile
source ~/.bashrc
#install ruby
rvm install ruby-2.1.3

#install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.28.0/install.sh | bash
source ~/.bash_profile
source ~/.profile
source ~/.bashrc
# install node v0.10.x
nvm install 0.10

#install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
source ~/.bash_profile
brew update
brew tap Homebrew/bundle

# copy apps
cp -s $dir/Brewfile ~/

#Execute Brewfile
brew bundle

# create link comand to sublime tree
sudo ln -s /Applications/Sublime\ Text/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl3
