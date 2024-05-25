#!/usr/bin/env python3

import sys
import re

def fitsScreen(p):
    lines = p.rsplit("\n")
    chars = max(lines, key=lambda l: len(l))
    cond = len(lines) < 9 and len(chars) < 16
    if not cond:
        print(p, len(lines), len(chars))
    return cond

if __name__ == "__main__":
    with open(sys.argv[1], "r") as microban:
        ps = re.split(r"\;.*\d+", microban.read())
        ps = [p.lstrip("\n").rstrip(" \n") for p in ps]
        ps = list(filter(lambda p: fitsScreen(p), ps))
        for n, p in enumerate(ps[1:]):
            with open(f"microban-{n}", "w") as f:
                f.write(p)
