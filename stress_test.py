import os
import re
import subprocess
import sys

from colorama import Fore

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
        print(f"{it} Test passed", end="\r")
        subprocess.run(f"./{generator}.exe > {generator}.out", shell=True)
        subprocess.run(f"./{brute}.exe < {generator}.out > {brute}.out", shell=True)
        subprocess.run(f"./{wrong}.exe < {generator}.out > {wrong}.out", shell=True)
        with open(f"{brute}.out") as output_brute, open(f"{wrong}.out") as output_wrong:
            brute_out = output_brute.read()
            wrong_out = output_wrong.read()
            brute_out = re.sub(r"\s+", " ", brute_out).strip()
            wrong_out = re.sub(r"\s+", " ", wrong_out).strip()

        if brute_out != wrong_out:
            print(Fore.BLUE + "\ntest failed on input:" + Fore.WHITE)
            subprocess.run(f"cat {generator}.out", shell=True)
            print(Fore.GREEN + "\n\nbrute solution output:" + Fore.WHITE)
            subprocess.run(f"cat {brute}.out", shell=True)
            print(Fore.RED + "\nwrong solution output:" + Fore.WHITE)
            subprocess.run(f"cat {wrong}.out", shell=True)
            return
    else:
        print(Fore.GREEN + f"{iterations} tests passed")


try:
    build()
    stress_test()

except:
    exit()
