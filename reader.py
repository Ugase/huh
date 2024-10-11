"""
Helper functions
"""

import os

def copy_files(files: list, dest: list):
    if len(files) != len(dest):
        raise ValueError("Not right length!")
    for f, d in zip(files, dest):
        if os.system(f"cp -fv {f} {d}") > 0:
            exit(1)


def copy_dirs(files: list, dest: list):
    if len(files) != len(dest):
        raise ValueError("Not right length!")
    for f, d in zip(files, dest):
        if os.system(f"cp -frv {f} {d}") > 0:
            exit(1)


def read_paths(path):
    path = f"./files/{path}"
    path_dest = f"{path}.dest"
    with open(path) as files:
        f = files.read()
        f2 = f.split("\n")
    with open(path_dest) as dests:
        d = dests.read()
        d2 = d.split("\n")
    return [f2, d2]


def ansi(ansi_code: str, text: str):
    ansi_code = f"\x1b[{ansi_code}m"
    normal = "\x1b[0m"
    return f"{ansi_code}{text}{normal}"
