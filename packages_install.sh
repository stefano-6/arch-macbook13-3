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

echo "Intalling hyprland..."
install_pkg "${HYPRLAND[@]}"

echo "Intalling browsers..."
install_pkg "${BROWSERS[@]}"


