#!/bin/bash

# Clear terminal and print logo
clear
# print_logo

# Exit on any error
set -e

# Source utils.sh
source utils.sh

# Check if a package list exists
if [ ! -f "package.conf" ]; then
    echo "ERROR: package.conf not found"
    exit 1
fi

# Source package.conf
source packages.conf

echo "Prepare the installation..."

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install yay AUR helper
if ! command -v yay &> /dev/null; then
    echo "Installng yay AUR helper..."
    sudo pacman -S --needed git base-devel --noconfirm
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
else
    echo "yay is already installed"
fi

# Install packages
echo "Intalling terminals..."
install_pkg "${TEREMINALS[@]}"

echo "Intalling login manager..."
install_pkg "${LOGIN[@]}"

echo "Intalling hyprland..."
install_pkg "${HYPRLAND[@]}"

echo "Intalling browsers..."
install_pkg "${BROWSERS[@]}"

echo "Intalling other packages..."
install_pkg "${OTHER[@]}"

# Move up to git directory
cd ..

# Clone the dotfiles-arch.git reposetory
git clone https://github.com/stefano-6/dotfiles-arch.git
cd dotfiles-arch

# Check and delete original folder
if [ -d ~/.config/ghostty ]; then
  echo "Remove existing ghostty directory..."
fi

#Stow ghostty
echo "Stow ghostty..."
stow --target=~ ghostty

# Check and delete original folder
if [ -d ~/.config/hypr ]; then
  echo "Remove existing hypr directory..."
fi

#Stow hypr
echo "Stow hypr..."
stow --target=~ hypr

# Check and delete original folder
if [ -d ~/.config/waybar ]; then
  echo "Remove existing waybar directory..."
fi

#Stow waybar
echo "Stow waybar..."
stow --target=~ waybar

# Check and delete original file
if [ -f ~/.config/starship.toml ]; then
  echo "Remove existing starship.toml file..."
fi

#Stow starship.toml
echo "Stow starship.toml..."
stow --target=~ starship.toml

# Check and delete original file
if [ -f ~/.config/starship.toml ]; then
  echo "Remove existing starship.toml file..."
fi

#Stow starship.toml
echo "Stow starship.toml..."
stow --target=~ starship

# Check and delete original file
if [ -f ~/.bash_profile ]; then
  echo "Remove existing .bash_profile file..."
fi

#Stow .bash_profile
echo "Stow .bash_profile..."
stow --target=~ profile

# Check and delete original file
if [ -f ~/.bashrc ]; then
  echo "Remove existing .bashrc file..."
fi

#Stow .bashrc
echo "Stow .bashrc..."
stow --target=~ bashrc
