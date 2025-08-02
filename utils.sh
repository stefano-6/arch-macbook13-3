# Check if package is installed
is_pkg_intalled() {
    pacman -Qi "$1" &> /dev/null
}

# Check if package group is installed
is_pkg_group_intalled() {
    pacman -Qg "$1" &> /dev/null
}

# Install package if nor intalled yet
install_pkg() {
    local pkg_list=("$@")
    local pkg_to_intsall=()

    for pkg in "${pkg_list[@]}"; do
        if ! is_pkg_installed "$pkg" && ! is_pkg_group_installed "$pkg"; then
	    pkg_to_install+=("$pkg")
	fi
    done

    if [ ${#pkg_to_install[@]} -ne 0 ]; then
	echo "Installing: ${pks_to_intall[@]}
	yay -S --noconfirm "{pks_to_intall[@]}"
    fi
}
