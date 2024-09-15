#!/bin/bash
echo "Choose a terminal emulator:"
echo "1. Alacritty"
echo "2. Konsole"
read -p "Enter your choice (1/2): " choice
case $choice in
    1) 
        TERMINAL_EMULATOR="alacritty"
        if ! [ -f "alacritty.toml" ]; then
          echo "The alacritty config file is missing"
          exit 1
        fi
        ;;
    2) 
        TERMINAL_EMULATOR="konsole"
        if ! [ -f "good.profile" ]; then
          echo "The konsole profile is missing"
          exit 1
        fi
        if ! [ -f "Tokyo Night.colorscheme" ]; then
          echo "The Tokyo Night colorscheme is missing"
          exit 1
        fi
        ;;
    *)
        echo "Invalid choice. Please choose 1 or 2."
        exit 1
        ;;
esac
if ! [ -f "FiraMonoNerdFont-Regular.otf" ]; then
    echo "The Fira code font is missing"
    exit 1
fi
if ! [ -f "config.fish" ]; then
    echo "The fish config is missing"
    exit 1
fi
if ! [ -f "config.jsonc" ]; then
    echo "The fastfetch config is missing"
    exit 1
fi
echo "Installing packages"
echo "-------------------"
sudo pacman -S --needed go neovim sddm-kcm fastfetch npm wget fish
if [ "$TERMINAL_EMULATOR" = "alacritty" ]; then

    sudo pacman -S --needed alacritty

elif [ "$TERMINAL_EMULATOR" = "konsole" ]; then

    sudo pacman -S --needed konsole

fi
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ../
git clone https://github.com/cirho/powerline-rust
cd powerline-rust
cargo install --path . --no-default-features --features=bare-shell,libgit
cd ../
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
echo "Copying Font"
echo "------------"
sudo cp -fv "$PWD/PixelifySans-VariableFont_wght.ttf" /usr/local/share/fonts/
echo "Copying config files"
echo "-------------------"
cp -fv "$PWD/config.jsonc" ~/.config/fastfetch/config.jsonc
cp -fv "$PWD/config.fish" ~/.config/fish/config.fish
if [ "$TERMINAL_EMULATOR" = "alacritty" ]; then
    curl https://raw.githubusercontent.com/zatchheems/tokyo-night-alacritty-theme/main/tokyo-night-storm.toml > ~/.config/alacritty/themes/tokyo.toml
    cp -fv "$PWD/alacritty.toml" ~/.config/alacritty/alacritty.toml
else
    if [ "$TERMINAL_EMULATOR" = "konsole" ]; then
        cp -fv "$PWD/good.profile" ~/.local/share/konsole/good.profile
        cp -fv "$PWD/Tokyo Night.colorscheme" ~/.local/share/konsole/Tokyo\ Night.colorscheme
    fi
fi
