import os
import sys
import distro

from rich import print as rprint
import shutil


def command_exists(cmd):
    return shutil.which(cmd) is not None


def move_files(files: list, dest: list):
    if len(files) != len(dest):
        raise ValueError("Not right length!")
    for f, d in zip(files, dest):
        os.system(f"mv {f} {d}")
        rprint(f"[bold blue]Moved [bold green]{f}[/] to [bold green]{d}[/][/]")
config = "~/.config/"
konsole = "~/.local/share/konsole/"
font = "~/.local/share/fonts/"

try:
    emulator = sys.argv[1]
except IndexError:
    rprint("[blue]Please enter konsole or alacritty (case sensitive)[/]")
    exit(1)

if not emulator in ["alacritty", "konsole"]:
    rprint("[red]Choose either konsole or alacritty (case sensitive)[/]")
    exit(1)
if emulator == "konsole":
    files = [
        "./konsole/nice.profile/",
        "./konsole/Tokyonightstorm.colorscheme/",
        "./konsole/konsolerc/",
        "./fastfetch/",
        "./fish/",
        "./fonts/FiraMonoNerdFont-Regular.otf",
        "./fonts/JetBrainsMonoNerdFontMono-Regular.ttf",
        "./fonts/PixelifySans-VariableFont_wght.ttf",
    ]
    dest = [
        f"{konsole}/nice.profile/",
        f"{konsole}/Tokyonightstorm.colorscheme/",
        f"{config}/konsolerc/",
        f"{config}/fastfetch/",
        f"{config}/fish",
        f"{font}/FiraMonoNerdFont-Regular.otf",
        f"{font}/JetBrainsMonoNerdFontMono-Regular.ttf",
        f"{font}/PixelifySans-VariableFont_wght.ttf",
    ]
else:
    files = [
        "./alacritty/",
        "./fastfetch/",
        "./fish/",
        "./fonts/FiraMonoNerdFont-Regular.otf",
        "./fonts/JetBrainsMonoNerdFontMono-Regular.ttf",
        "./fonts/PixelifySans-VariableFont_wght.ttf",
    ]
    dest = [
        f"{config}/alacritty/",
        f"{config}/fastfetch/",
        f"{config}/fish",
        f"{font}/FiraMonoNerdFont-Regular.otf",
        f"{font}/JetBrainsMonoNerdFontMono-Regular.ttf",
        f"{font}/PixelifySans-VariableFont_wght.ttf",
    ]


distro_name = distro.id()
if distro_name != "arch":
    rprint("[bold red][ERROR] This linux distro is not arch[/]")
    exit(1)

if not command_exists("yay"):
    os.system(
        "sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    )
os.system("yay -S --needed fastfetch-git")
os.system("rm -rf ~/.config/nvim")
rprint("[bold green] Copying a neovim cofig from someone else[/]")
os.system("git clone -b v2.0 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1")
os.system("rm -rf ~/.config/nvim/lua/custom/")
os.system("git clone https://github.com/dreamsofcode-io/neovim-python.git ~/.config/nvim/lua/custom/")
rprint("[bold green]Moving config files[/]")
move_files(files, dest)
rprint(f"Cleaning up")
os.chdir("../")
os.system("rm -rf huh/")