#!/bin/python3

import os
import sys
import subprocess
from colorama import Fore

filename, extension = os.path.splitext(sys.argv[1])

def build():
    subprocess.run(f"runcode.sh {filename}.cpp < in > out", shell=True)

def run_samples():
    build()

    with open('out', 'r') as outfile, open('exp') as expfile:
        out = outfile.readlines()
        exp = expfile.readlines()
        
        for line1, line2 in zip(out, exp):
            if line1[:len(line1) - 2] != line2[:len(line2) - 1]:
                print(Fore.RED + "-- PRETEST FAILED --" + Fore.WHITE)
                print()
                subprocess.run("cat out", shell=True)
                return

        print(Fore.GREEN + "-- ALL PRETEST PASSED! --" + Fore.WHITE)

try:
    run_samples()
except:
    exit()
