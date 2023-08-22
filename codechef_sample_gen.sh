#!/bin/python3

import requests
import sys

def generate_sample(problem_code, index):
    url = f"https://www.codechef.com/api/contests/PRACTICE/problems/{problem_code}"
    response = requests.get(url)
    data = response.json()
    with open(f"{chr(index + ord('A'))}1.in", "w") as input, open(f"{chr(index + ord('A'))}1.exp", "w") as output:
        input.write(data["problemComponents"]["sampleTestCases"][0]["input"])
        output.write(data["problemComponents"]["sampleTestCases"][0]["output"])

try:  
    for index, arg in enumerate(sys.argv[1:]):
        generate_sample(arg, index)
except:
    print("Erro 404")
