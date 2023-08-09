#!/bin/python3

def codechef(problem_code):
    url = f"https://www.codechef.com/api/contests/PRACTICE/problems/{problem_code}"
    response = requests.get(url)
    data = response.json()
    with open("in", "w") as input, open("exp", "w") as output:
        input.write(data["problemComponents"]["sampleTestCases"][0]["input"])
        output.write(data["problemComponents"]["sampleTestCases"][0]["output"])

try:  
    codechef(sys.argv[1])
except:
    print("Erro 404")
