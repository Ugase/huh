import os
import readline
from rich import print as rprint
from rich.prompt import Prompt

home = os.environ.get("HOME")
pr = Prompt()
huh = pr.ask("huh project directory", default=f"{home}/huh_project/")

os.chdir(huh)
config = f"{home}/.config/"
konsole = f"{home}/.local/share/konsole/"
font = f"{home}/.local/share/fonts/"

kon = "./konsole/"

rm = ["alacritty", "fastfetch", "fish", "konsole"]
for d in rm:
    os.system(f"rm -rf {d}")
    rprint(f"[bold red]Removed {d}[/]")

os.mkdir(kon)

files = [
    f"{konsole}nice.profile",
    f"{konsole}Tokyonightstorm.colorscheme",
    f"{config}konsolerc",
    f"{konsole}/catppuccin-frappe.colorscheme",
]

dest = [
    f"{kon}nice.profile",
    f"{kon}Tokyonightstorm.colorscheme",
    f"{kon}konsolerc",
    f"{kon}/catppuccin-frappe.colorscheme",
]

dirs = [f"{config}fastfetch/", f"{config}fish/", f"{config}alacritty/"]


def copy_files(files: list, dest: list):
    for f, d in zip(files, dest):
        os.system(f"cp {f} {d}")
        rprint(f"[bold blue]Copied [bold green]{f}[/] -> [bold green]{d}[/][/]")


def copy_dirs(dirs: list, dest: str):
    for f in dirs:
        os.system(f"cp -r {f} {dest}")
        rprint(f"[bold blue]Copied [bold green]{f}[/] -> [bold green]{dest}[/][/]")


copy_dirs(dirs, huh)
copy_files(files, dest)


