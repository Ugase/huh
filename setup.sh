#!/bin/bash
echo "Choose a terminal emulator:"
echo "1. Alacritty"
echo "2. Konsole"
read -p "Enter your choice (1/2): " choice
case $choice in
    "1") 
        TERMINAL_EMULATOR="alacritty"
        ;;
    
    "2") 
        TERMINAL_EMULATOR="konsole"
        ;;
    
    *)
        echo "Invalid choice. Please choose 1 or 2."
        exit 1
        ;;
esac
echo "Installing packages"
echo "-------------------"
sudo pacman -S --needed go neovim fastfetch npm wget fish
if [ "$TERMINAL_EMULATOR" = "alacritty" ]; then
    sudo pacman -S --needed alacritty
elif [ "$TERMINAL_EMULATOR" = "konsole" ]; then
    sudo pacman -S --needed konsole
fi
if ! [ command -v yay 2>&1 >/dev/null ]
then
    sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
fi
cd ../
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
echo "Copying a neovim config from someone else"
echo "-----------------------------------------"
git clone -b v2.0 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
rm -rf ~/.config/nvim/lua/custom/
git clone https://github.com/dreamsofcode-io/neovim-python.git ~/.config/nvim/lua/custom/
echo "Making directories"
echo "------------------"
mkdir -p ~/.config/fish/
mkdir -p ~/.config/alacritty/themes/
mkdir -p ~/.config/fastfetch/
mkdir -p ~/.local/share/konsole/
echo "Downloading and Installing Font"
echo "-------------------------------"
sudo curl -L https://github.com/Ugase/huh/raw/main/FiraMonoNerdFont-Regular.otf > /usr/local/share/fonts/FiraMonoNerdFont-Regular.otf
sudo curl -L https://github.com/Ugase/huh/raw/main/JetBrainsMonoNerdFontMono-Regular.ttf > /usr/local/share/fonts/JetBrainsMonoNerdFontMono-Regular.ttf
echo "Downloading and Installing config files"
echo "---------------------------------------"
curl -L https://github.com/Ugase/huh/raw/main/config.jsonc > ~/.config/fastfetch/config.jsonc
curl -L https://github.com/Ugase/huh/raw/main/config.fish > ~/.config/fish/config.fish
fisher install jorgebucaran/hydro
if [ "$TERMINAL_EMULATOR" = "alacritty" ]; then
    curl -s https://raw.githubusercontent.com/zatchheems/tokyo-night-alacritty-theme/main/tokyo-night-storm.toml > ~/.config/alacritty/themes/tokyo.toml
    curl -L https://github.com/Ugase/huh/raw/main/alacritty.toml > ~/.config/alacritty/alacritty.toml
else
    if [ "$TERMINAL_EMULATOR" = "konsole" ]; then
        curl -L https://github.com/Ugase/huh/raw/main/good.profile > ~/.local/share/konsole/good.profile
        curl -L https://github.com/Ugase/huh/raw/main/Tokyo%20Night.colorscheme > ~/.local/share/konsole/Tokyo\ Night.colorscheme
        curl -L https://github.com/Ugase/huh/raw/main/konsolerc > ~/.config/konsolerc
    fi
fi
