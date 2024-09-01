sudo pacman -S --needed go neovim sddm-kcm fastfetch npm wget alacritty fish
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
git clone -b v2.0 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
rm -rf ~/.config/nvim/lua/custom/
git clone https://github.com/dreamsofcode-io/neovim-python.git ~/.config/nvim/lua/custom/
mkdir -p ~/.config/fish/
mkdir -p ~/.config/alacritty/themes/
mkdir -p ~/.config/fastfetch/
curl https://raw.githubusercontent.com/Everblush/terminal-emulators/main/src/alacritty/Everblush.toml > ~/.config/alacritty/themes/
mv alacritty.toml ~/.config/alacritty/alacritty.toml
mv config.jsonc ~/.config/fastfetch/config.jsonc
sudo mv FiraMonoNerdFont-Regular.otf /usr/local/share/fonts/
sudo mv PixelifySans-VariableFont_wght.ttf /usr/local/share/fonts/
