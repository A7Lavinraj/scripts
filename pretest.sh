#!/bin/bash

# colors.
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BLACK='\033[0;30m'
BG_RED='\033[41m'
BG_GREEN='\033[42m' 
NC='\033[0m'

sampleList=(${@%.*}-*.in)
sampleList=("${sampleList[@]%.*}")
numberOfTests=${#sampleList[@]}
testPassed=0

for sample in ${sampleList[@]};
do
  dbrun.sh $1 < $sample.in > $sample.out
  echo -e "[Running for $sample.in]\n"

  if diff -B -w $sample.out $sample.exp > /dev/null; then
    ((testPassed++))
    echo -e "PRETEST $i: $BLACK$BG_GREEN PASSED $NC\n"
  else
    echo "Input-$i:"
    cat $sample.in | grep -v '^[[:space:]]*$'
    echo "----------------------"

    echo "Output-$i:"
    cat $sample.out | grep -v '^[[:space:]]*$'
    echo "----------------------"

    echo "Expected-$i:"
    cat $sample.exp | grep -v '^[[:space:]]*$'
    echo "----------------------"

    echo -e "PRETEST $i: $BLACK$BG_RED FAILED $NC\n"
  fi
done

if [ $testPassed -eq $numberOfTests ]; then
  echo -e "$GREEN($testPassed / $numberOfTests) PRETEST PASSED$NC"
else
  echo -e "$RED($testPassed / $numberOfTests) PRETEST PASSED$NC"
fi

cat "$1" | xclip -selection clipboard
