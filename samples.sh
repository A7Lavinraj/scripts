#!/bin/python3

import sys
import os
import subprocess
import requests
from bs4 import BeautifulSoup

# global declaration
response = requests.get(sys.argv[1])
soup = BeautifulSoup(response.content, 'html.parser')
sample_list = soup.find_all('pre')


def make_samples(): # for wirting samples in file

    if len(sample_list) == 2:

        with open("input.txt", "a") as file: # start appending testcases line by line (input samples)
            for input_samples in sample_list[0]:
                for line in input_samples:
                    file.write(line)

                file.write("\n")

            file.write("\n")

        with open("expected.txt", "a") as file: # start appending testcases line by line (output samples)

            for output_samples in sample_list[1]:
                file.write(output_samples.text)

    else:

        for index in range(0, len(sample_list), 2): # start appending testcases line by line (input samples)
            with open(f"in{int(index / 2) + 1}.txt", "a") as file:
                for input_sample in sample_list[index]:
                    file.write(input_sample.text)

        for index in range(1, len(sample_list), 2): # start appending testcases line by line (ouput samples)
            with open(f"out{int(index / 2) + 1}.txt", "a") as file:
                for output_sample in sample_list[index]:
                    file.write(output_sample.text)

def fetch_sample_testcases():
    if response.status_code != 200:
        print('Failed to fetch problem page.')
        return
    
    make_samples()

fetch_sample_testcases()
