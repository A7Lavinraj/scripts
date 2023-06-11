#!/bin/python3

import sys
import os
import subprocess
import filecmp

wrong, _ = os.path.splitext(sys.argv[1])
brute, _ = os.path.splitext(sys.argv[2])
generator, _ = os.path.splitext(sys.argv[3])
iterations = sys.argv[4]

def build():
    subprocess.run(f"g++ {wrong}.cpp -o {wrong}.exe", shell=True)
    subprocess.run(f"g++ {brute}.cpp -o {brute}.exe", shell=True)
    subprocess.run(f"g++ {generator}.cpp -o {generator}.exe", shell=True)

def stress_test():
    for it in range(int(iterations)):
        subprocess.run(f"./{generator}.exe > genOut.txt", shell=True)
        subprocess.run(f"./{brute}.exe < genOut.txt > bruteOut.txt", shell=True)
        subprocess.run(f"./{wrong}.exe < genOut.txt > wrongOut.txt", shell=True)
        if filecmp.cmp("bruteOut.txt", "wrongOut.txt"):
            print(f"test {it + 1} passed")
        else:
            print("test failed on input:")
            subprocess.run("cat genOut.txt", shell=True)
            print("\nbrute solution output:")
            subprocess.run("cat bruteOut.txt", shell=True)
            print("\nwrong solution output:")
            subprocess.run("cat wrongOut.txt", shell=True)
            print()
            break
            


try:
    build()
    stress_test()

except:
    exit()
