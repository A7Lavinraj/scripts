#!/bin/python3

import sys
import os
import subprocess
import filecmp
from colorama import Fore

wrong, _ = os.path.splitext(sys.argv[1])
brute, _ = os.path.splitext(sys.argv[2])
generator, _ = os.path.splitext(sys.argv[3])
iterations = sys.argv[4]

def build():
    subprocess.run(f"g++ {wrong}.cpp -o {wrong}", shell=True)
    subprocess.run(f"g++ {brute}.cpp -o {brute}", shell=True)
    subprocess.run(f"g++ {generator}.cpp -o {generator}", shell=True)

def stress_test():
    for it in range(int(iterations)):
        subprocess.run(f"./{generator} > genOut", shell=True)
        subprocess.run(f"./{brute} < genOut > bruteOut", shell=True)
        subprocess.run(f"./{wrong} < genOut > wrongOut", shell=True)
        if not filecmp.cmp("bruteOut", "wrongOut"):
            print(Fore.BLUE + "\ntest failed on input:" + Fore.WHITE)
            subprocess.run("cat genOut", shell=True)
            print(Fore.GREEN + "\n\nbrute solution output:" + Fore.WHITE)
            subprocess.run("cat bruteOut", shell=True)
            print(Fore.RED + "\nwrong solution output:" + Fore.WHITE)
            subprocess.run("cat wrongOut", shell=True)
            return
    print(Fore.GREEN + f"{iterations} tests passed")
            


try:
    build()
    stress_test()
    subprocess.run("rm wrongOut bruteOut genOut", shell=True)

except:
    exit()
