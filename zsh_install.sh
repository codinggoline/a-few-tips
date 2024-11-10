#!/bin/bash

## Example: https://itsfoss.com/zsh-ubuntu/

## Zsh Installation
# Update package
sudo apt-get update

# Install Zsh
sudo apt-get install zsh

# Check version
zsh --version

# Define Zsh as default shell
chsh -s $(which zsh)


## Oh My Zsh Installation
# Download the script
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


## Adding autocompletion and syntax coloring
# Autocompletion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#### After this, add zsh-autosuggesions on plugins

# Syntax color
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#### Add zsh-syntax-highlighting


## Customizing theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#### After this command, replace the theme by: powerlevel10k/powerlevel10k


# ============================ Uninstalling ===========================
echo "Uninstalling ..."
chsh -s /bin/bash
sudo apt remove zsh
rm -rf ~/.zsh ~/.oh-my-zsh ~/.zshrc ~/.p10k.zsh
