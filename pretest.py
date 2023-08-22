import os
import sys
import subprocess
import re
import glob
import time
from colorama import Fore

filename, extension = os.path.splitext(sys.argv[1])

def run_samples():
    subprocess.run(f"g++ -std=c++20 {filename}.cpp -o {filename}.exe", shell=True)

    number_of_pretests = len(glob.glob(f"{filename}*.in"))

    passed = 0
    failed = 0
    total_time = 0
    time_ptr = 0
    for index in range(number_of_pretests):
        print(f"Input for sample-{index + 1}:")
        subprocess.run(f"cat {filename}{index + 1}.in | grep -v '^[[:space:]]*$'", shell=True)
        print("---------------------")

        time_ptr = time.time()
        subprocess.run(f"./{filename}.exe < {filename}{index + 1}.in > {filename}.out", shell=True)
        total_time = total_time + time.time() - time_ptr

        with open(f"{filename}.out") as out, open(f"{filename}{index + 1}.exp") as exp:
            out_text = out.read()
            exp_text = exp.read()
            out_text = re.sub(r'\s+', ' ', out_text).strip()
            exp_text = re.sub(r'\s+', ' ', exp_text).strip()

        print(f"Output for sample-{index + 1}:")
        subprocess.run(f"cat {filename}.out | grep -v '^[[:space:]]*$'", shell=True)
        print("---------------------")
        print(f"Expected for sample-{index + 1}:")
        subprocess.run(f"cat {filename}{index + 1}.exp | grep -v '^[[:space:]]*$'", shell=True)
        print("---------------------")

        if out_text == exp_text:
            passed += 1
        else:
            failed += 1;

    print(f"Finished in {total_time} sec.")
    if failed == 0:
        print(Fore.GREEN + "Passed:")
        print(f"({passed} / {number_of_pretests}) pretests passed" + Fore.WHITE)
        subprocess.run(f"cat {sys.argv[1]}| xclip -selection clipboard", shell=True)
    else:
        print(Fore.RED + "Failed")
        print(f"({passed} / {number_of_pretests}) pretests passed" + Fore.WHITE)
try:
    run_samples()
except:
    exit()
