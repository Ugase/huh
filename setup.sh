#!/bin/bash
if ! [ -f "PixelifySans-VariableFont_wght.ttf" ]; then
echo "The file PixelifySans-VariableFont_wght.ttf does not exist"
exit 1
fi
if ! [ -f "FiraMonoNerdFont-Regular.otf" ]; then
echo "The file does FiraMonoNerdFont-Regular.otf not exist"
exit 1
fi
if ! [ -f "alacritty.toml" ]; then
echo "The file alacritty.toml does not exist"
exit 1
fi
if ! [ -f "config.fish" ]; then
echo "The file config.fish does not exist"
exit 1
fi
if ! [ -f "config.jsonc" ]; then
echo "The file config.jsonc does not exist"
exit 1
fi
echo "Installing packages"
echo "-------------------"
sudo pacman -S --needed go neovim sddm-kcm fastfetch npm wget alacritty fish
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
echo "Copying a neovim config from someboy else"
echo "-----------------------------------------"
git clone -b v2.0 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
rm -rf ~/.config/nvim/lua/custom/
git clone https://github.com/dreamsofcode-io/neovim-python.git ~/.config/nvim/lua/custom/
echo "Making directories"
echo "------------------"
mkdir -p ~/.config/fish/
mkdir -p ~/.config/alacritty/themes/
mkdir -p ~/.config/fastfetch/
echo "Copying Fonts"
echo "------------"
sudo cp -f $PWD/FiraMonoNerdFont-Regular.otf /usr/local/share/fonts/
sudo cp -f $PWD/PixelifySans-VariableFont_wght.ttf /usr/local/share/fonts/
echo "Installing alacritty theme"
echo "--------------------------"
curl https://raw.githubusercontent.com/Everblush/terminal-emulators/main/src/alacritty/Everblush.toml > ~/.config/alacritty/themes/everblush.toml
echo "Copying config files"
echo "-------------------"
cp -f $PWD/alacritty.toml ~/.config/alacritty/alacritty.toml
cp -f $PWD/config.jsonc ~/.config/fastfetch/config.jsonc
cp -f $PWD/config.fish ~/.config/fish/config.fish
