#!/bin/python3

import os
import sys
import subprocess
import filecmp
from colorama import Fore

filename, extension = os.path.splitext(sys.argv[1])

def build():

    subprocess.run(f"runcode.sh {filename}.cpp < in > out", shell=True)

def comparator():

    if filecmp.cmp("out", "exp"):
        print(Fore.GREEN + "pretest passed!")
    else:
        print(Fore.RED + "pretest failed" + Fore.WHITE)
        subprocess.run("cat out", shell=True)
        print()

def run_samples():

    build()
    comparator()

try:
    run_samples()
except:
    exit()
