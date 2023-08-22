#!/bin/bash

TEST_FILE=$1
TEST_FILE="${TEST_FILE%.*}"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BLACK='\033[0;30m'

BG_RED='\033[41m'
BG_GREEN='\033[42m' 

NC='\033[0m'


function compile_file() {
  g++ -std=c++20 $TEST_FILE.cpp -o $TEST_FILE.exe
}

function output_to_file() {
  ./$TEST_FILE.exe < $1 > $TEST_FILE.out
}

function pretest() {
  compile_file

  SAMPLES=($TEST_FILE*.in)
  LENGTH=${#SAMPLES[@]}
  TEST_PASSED=0

  echo "------------------"
  for ((i = 1; i <= LENGTH; i++));
  do
    output_to_file $TEST_FILE$i.in

    echo "Input-$i:"
    cat $TEST_FILE$i.in | grep -v '^[[:space:]]*$'
    echo "------------------"

    echo "Output-$i:"
    cat $TEST_FILE.out | grep -v '^[[:space:]]*$'
    echo "------------------"

    echo "Expected-$i:"
    cat $TEST_FILE$i.exp | grep -v '^[[:space:]]*$'
    echo "------------------"

    if diff -B -w $TEST_FILE.out $TEST_FILE$i.exp > /dev/null; then
      ((TEST_PASSED++))
    fi
  done

  if [ $TEST_PASSED -eq $LENGTH ]; then
    echo -e "$BLACK$BG_GREEN\r PASSED $NC\n"
    echo -e "$GREEN($TEST_PASSED / $LENGTH) PRETEST PASSED$NC\n"
  else
    echo -e "$BLACK$BG_RED\r FAILED $NC\n"
    echo -e "$RED($TEST_PASSED / $LENGTH) PRETEST PASSED$NC\n"
  fi

}

cat "$TEST_FILE.cpp" | xclip -selection clipboard

pretest
