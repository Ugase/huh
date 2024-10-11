import os
import readline
from reader import *

home = os.environ.get("HOME")
huh = input("\x1b[94mhuh project directory: \x1b[0m")

if not huh:
    huh = f"{home}/huh_project/"

os.chdir(huh)

os.mkdir("./konsole/")

files, dest = read_paths("all")
dirs, dirsd = read_paths("ad")
copy_dirs(dirs, dirsd)
copy_files(files, dest)
