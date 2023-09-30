#!/bin/bash

WRONG_FILE=$1
BRUTE_FILE=$2
GENERATOR_FILE=$3
NUMBER_OF_TESTCASE=$4

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

function compiling_files() {
  g++ -std=c++20 $WRONG_FILE.cpp -o $WRONG_FILE.exe
  g++ -std=c++20 $BRUTE_FILE.cpp -o $BRUTE_FILE.exe
  g++ -std=c++20 $GENERATOR_FILE.cpp -o $GENERATOR_FILE.exe
}

function generate_input() {
  ./$GENERATOR_FILE.exe > $GENERATOR_FILE.out
}

function store_output() {
  ./$WRONG_FILE.exe < $GENERATOR_FILE.out > $WRONG_FILE.out
  ./$BRUTE_FILE.exe < $GENERATOR_FILE.out > $BRUTE_FILE.out
}

function stress_test() {
  compiling_files

  for ((i == 0; i < $NUMBER_OF_TESTCASE; i++));
  do

    generate_input
    store_output

    if diff -w -B $WRONG_FILE.out $BRUTE_FILE.out > /dev/null; then
      echo -ne "\r$GREEN\rTest Passed $(($i + 1))$NC"
    else
      echo -e "\r$RED\rFailed on test case $(($i + 1))$NC\n"

      echo -e "$BLUE\rInput:$NC"
      cat $GENERATOR_FILE.out | grep -v '^[[:space:]]*$'
      echo

      echo -e "$RED\rOutput:$NC"
      cat $WRONG_FILE.out | grep -v '^[[:space:]]*$'
      echo

      echo -e "$GREEN\rExpected:$NC"
      cat $BRUTE_FILE.out | grep -v '^[[:space:]]*$'
      break
    fi

  done
}

stress_test
rm -f *.exe
echo
