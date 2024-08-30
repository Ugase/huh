pacman -S --needed go dolphin
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -S zen-browser-bin
