#!/bin/bash

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

if [ $extension == cc ]; then
  echo "[ DEBUG MODE ]"
  g++ -std=c++20 $filename.cc -DDEBUG -o $filename && ./$filename
elif [ $extension == cpp ]; then
  echo "[ DEBUG MODE ]"
  g++ -std=c++20 -DDEBUG $filename.cpp -o $filename && ./$filename
elif [ $extension == c ]; then
  echo "[ DEBUG MODE ]"
  gcc $filename.c -DDEBUG -o $filename.exe && ./$filename
else
  echo "NOT! compatible"
fi