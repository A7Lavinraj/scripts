#!/bin/python3

import requests
import re
import sys
from colorama import Fore
from bs4 import BeautifulSoup

def progress_bar(progress, total):
    percent = progress / total * 20
    print(Fore.YELLOW + "fetching problems | " + '\u2588' * int(percent) + " " * (20 - int(percent)) + f"| {progress} out of {total} problems fetched", end='\r')
    if int(percent) == 20:
        print(Fore.GREEN + "fetching problems | " + '\u2588' * int(percent) + " " * (20 - int(percent)),  f"| {progress} out of {total} problems fetched" + Fore.WHITE)

def problem_set(url):
    response = requests.get(url)
    HTML = BeautifulSoup(response.text, "html.parser")
    HTML = HTML.find_all('td', class_="id")

    problem_id = []
    for id in HTML:
        problem_id.append(re.sub(r'\s+', ' ', id.find('a').text).strip())

    return problem_id

def create_sample_files(input, output, problem_id):
    with open(f"{problem_id}.in", 'w') as input_file:
        input_file.write(input)
    
    with open(f"{problem_id}.exp", 'w') as output_file:
        output_file.write(output)


def fetch_problem(url, problem_id):
    response = requests.get(url)
    HTML = BeautifulSoup(response.text, "html.parser")

    number_of_testcase = len(HTML.find_all('div', class_="input"))

    if (number_of_testcase == 1):
        input = ""
        for test in HTML.find_all('div', class_="input"):
            input = ""
            if HTML.find('div', class_='test-example-line') == None:
                input += test.find('pre').text
            else:
                for line in HTML.find_all('div', class_='test-example-line'):
                    input += line.text + '\n'

        output = ""
        for test in HTML.find_all('div', class_="output"):
            for line in test.find_all('pre'):
                output += line.text

        create_sample_files(input, output, problem_id + "1")

    else:
        input_list = []
        output_list = []

        for test in HTML.find_all('div', class_="input"):
            input = ""
            for line in test.find_all('pre'):
                input += line.text + "\n"

            input_list.append(input)

        for test in HTML.find_all('div', class_="output"):
            output = ""
            for line in test.find_all('pre'):
                output += line.text

            output_list.append(output)
        
        for test in range(int(number_of_testcase)):
            create_sample_files(input_list[test], output_list[test], problem_id + f"{test + 1}")

if __name__ == "__main__":
    MODE = sys.argv[1]

    if MODE == "contest":
        contest_id = sys.argv[2]
        url = f"https://codeforces.com/contest/{contest_id}"
        problems = problem_set(url)

        for index, problem in enumerate(problems):
            fetch_problem(url + f"/problem/{problem}", problem)
            progress_bar(index + 1, len(problems))

    elif MODE == "problem":
        for index, problem in enumerate(sys.argv[2:]):
            url = f"https://codeforces.com/contest/{problem[:-1]}/problem/{problem[-1]}"
            fetch_problem(url, chr(ord('A') + index))
            progress_bar(index + 1, len(sys.argv[2:]))

    else:
        print("Bad arguments please refer to github readme.")
