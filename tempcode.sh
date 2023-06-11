#!/bin/python3

import sys

content = open("/home/lavinraj/career/code-library/template.cpp", 'r').read()

for filename in sys.argv[1:]:
  file = open("{}.cpp".format(filename), 'w')
  file.write(content)
