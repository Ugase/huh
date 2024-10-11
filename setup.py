import os
import shutil
import sys

import distro

from reader import *

try:
    emulator = sys.argv[1]
except IndexError:
    print(ansi("34", "Please enter konsole or alacritty (case sensitive)"))
    exit(1)

print(ansi("33" ,"I will kill your config do you wish to proceed: "), end="")
tr = input()
if tr.lower() != "y":
    exit(0)


def command_exists(cmd):
    return shutil.which(cmd) is not None


home = os.environ.get("HOME")
config = f"{home}/.config/"
konsole = f"{home}/.local/share/konsole/"

try:
    os.mkdir(f"{home}/.config/fish/themes")
except:
    pass

if not emulator in ["alacritty", "konsole"]:
    print(ansi("31", "Choose either konsole or alacritty (case sensitive)"))
    exit(1)
if emulator == "konsole":
    files, dest = read_paths("konsole")
    dirs, dirsd = read_paths("kdir")
else:
    dirs, dirsd = read_paths("alacritty")

distro_name = distro.id()
if distro_name != "arch":
    print(ansi("31", "[ERROR] This linux distro is not arch"))
    exit(1)

if not command_exists("yay"):
    os.system(
        "sudo pacman -S --needed git base-devel go && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    )
os.system("yay -S --needed fastfetch-git")
os.system(f"rm -rf {home}/.config/nvim")
print(ansi("32", "Copying a neovim cofig from someone else"))
os.system(
    f"git clone -b v2.0 https://github.com/NvChad/NvChad {home}/.config/nvim --depth 1"
)
os.system(f"rm -rf {home}/.config/nvim/lua/custom/")
os.system(
    f"git clone https://github.com/dreamsofcode-io/neovim-python.git {home}/.config/nvim/lua/custom/"
)
print(ansi("32", "Moving config files"))
if emulator == "konsole":
    copy_files(files, dest)
copy_dirs(dirs, dirsd)
os.system("""fish -c 'fish_config theme save "Catppuccin Frappe"'""")
print(ansi("31", "Cleaning up"))
os.chdir("../")
os.system("rm -rf huh/")
