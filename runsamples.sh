#!/bin/python3

import os
import sys
import subprocess
from colorama import Fore

filename, extension = os.path.splitext(sys.argv[1])

def build():

    subprocess.run(f"g++ -std=c++20 -Wall -Wextra -Wshadow -D_GLIBCXX_ASSERTIONS -DDEBUG -ggdb3 -fmax-errors=2 {filename}.cpp -o {filename}.exe", shell=True)
    subprocess.run(f"./{filename}.exe < input.txt > output.txt", shell=True)

def comparator():

    output = open("output.txt", "r").readlines()
    expected = open("expected.txt", "r").readlines()
    inp = open("input.txt", "r").readlines()

    each = int((len(inp) - 1) / int(inp[0]))

    for testcase in range(0, len(expected), each):
        for testline in range(testcase, testcase + each):
          if output[testline][:len(output[testline]) - 1] == expected[testline]:
                print(Fore.GREEN + f"Pretest {testline + 1} passed")
                continue
          else:
                print(Fore.MAGENTA + f"Wrong answer on Pretest {testline + 1}")
                print(Fore.WHITE + output[testline], end="")
                print(Fore.RED + expected[testline])

def run_samples():

    build()
    comparator()

run_samples()
