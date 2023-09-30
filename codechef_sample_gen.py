import requests
import sys
from colorama import Fore

def progress_bar(progress, total):
    percent = progress / total * 20
    print(Fore.YELLOW + "fetching problems | " + '\u2588' * int(percent) + " " * (20 - int(percent)) + f"| {progress} out of {total} problems fetched", end='\r')
    if int(percent) == 20:
        print(Fore.GREEN + "fetching problems | " + '\u2588' * int(percent) + " " * (20 - int(percent)),  f"| {progress} out of {total} problems fetched" + Fore.WHITE)

def problem_set(url):
    response = requests.get(url)

    problems = []
    for problem in response.json()["problems"]:
        problems.append(problem)

    return problems

def fetch_problem(url, problem_id):
    response = requests.get(url)
    data = response.json()

    with open(f"{problem_id}1.in", "w") as input, open(f"{problem_id}1.exp", "w") as output:
        input.write(data["problemComponents"]["sampleTestCases"][0]["input"])
        output.write(data["problemComponents"]["sampleTestCases"][0]["output"])

try:  
    MODE = sys.argv[1]

    if MODE == "contest":
        contest_id = sys.argv[2]
        url = f"https://codechef.com/api/contests/{contest_id}/"
        problems = problem_set(url)

        progress_bar(0, len(problems))
        for index, problem in enumerate(problems):
            problem_url = f"https://codechef.com/api/contests/{contest_id}/problems/{problem}"

            fetch_problem(problem_url, chr(index + ord('A')))
            progress_bar(index + 1, len(problems))

    elif MODE == "problem":
        progress_bar(0, len(sys.argv[2:]))

        for index, problem in enumerate(sys.argv[2:]):
            url = f"https://codechef.com/api/contests/PRACTICE/problems/{problem}";
            fetch_problem(url, chr(index + ord('A')))
            progress_bar(index + 1, len(sys.argv[2:]))
        

except:
    print("Error 404")
