#!/bin/python3

import os
import sys
import subprocess

filename, extension = os.path.splitext(sys.argv[1])

def build():

    if extension == ".cpp":
        subprocess.run(f"g++ -std=c++20 {filename}.cpp -o {filename}.exe", shell=True)
        subprocess.run(f"./{filename}.exe", shell=True)

    elif extension == ".cc":
        subprocess.run(f"g++ -std=c++20 -Wall -Wextra -Wshadow -D_GLIBCXX_ASSERTIONS -DDEBUG -ggdb3 -fmax-errors=2 {filename}.cc -o {filename}", shell=True)
        subprocess.run(f"./{filename}.exe", shell=True)

    elif extension == ".py":
        subprocess.run(f"python3 {filename}.py", shell=True)

    elif extension == ".js":
        subprocess.run(f"node {filename}.js", shell=True)

    elif extension == ".rs":
        subprocess.run(f"rustc {filename}.rs -o {filename}.exe", shell=True)
        subprocess.run(f"./{filename}.exe", shell=True)

    else:
        subprocess.Popen('echo "NOT! compatible"')

try:
    build()
except:
    exit()
