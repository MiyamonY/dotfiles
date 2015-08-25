#!/bin/sh

# install xcode
sudo xcode-select —-install sudo xcodebuild —license


# install brew/brew file
curl -fsSL https://raw.github.com/rcmdnk/homebrew-file/install/install.sh |sh

# ssh
ssh-keygen

echo “set pubkey”
 # get dotfiles from git
mkdir ${HOME}/projects
cd ${HOME}/projects
git clone git@github.com:MiyamonY/dotfiles.git

# mv dotfiles to home dir
cd ./dotfiles
./install.sh 
cd ${HOME}

chmod +x .bash_profile
chmod +x .bashrc

# read .bash_profile
./.bash_profile

# install apps
brew file install

