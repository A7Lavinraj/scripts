import sys
import requests
from bs4 import BeautifulSoup

def fetch_samples(url, filename):

    print(f"fetching samples from {url}")
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')
    sample_list = soup.find_all('pre')

    if len(sample_list) == 2:

        print(f"Writing input samples in {filename}1.in")
        with open(f"{filename}1.in", "w") as file:
            for input_samples in sample_list[0]:
                for line in input_samples:
                    file.write(line)

                file.write("\n")

            file.write("\n")

        print(f"Writing expected samples in {filename}1.exp")
        with open(f"{filename}1.exp", "w") as file:

            for output_samples in sample_list[1]:
                file.write(output_samples)

    else:

        for index in range(0, len(sample_list), 2):
            print(f"Writing input samples in {filename}{index}.in")
            with open(f"{filename}{int(index / 2) + 1}.in", "w") as file:
                for input_sample in sample_list[index]:
                    file.write(input_sample)

        for index in range(1, len(sample_list), 2):
            print(f"Writing expected samples in {filename}{index}.exp")
            with open(f"{filename}{int(index / 2) + 1}.exp", "w") as file:
                for output_sample in sample_list[index]:
                    file.write(output_sample)

try:
    MODE = sys.argv[1]

    if MODE == "-c":
        contest_id = sys.argv[2]

        for problem in sys.argv[3:]:
            fetch_samples(f"https://codeforces.com/contest/{contest_id}/problem/{problem}", problem)
            print("contest...")

    elif MODE == "-p":
        for index, problem in enumerate(sys.argv[2:]):
            fetch_samples(f"https://codeforces.com/problemset/problem/{problem}", chr(index + ord('A')))

except:
    print("Error 404")
