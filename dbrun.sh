#!/bin/bash

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

if [ $extension == cc ]; then
  g++ -std=c++20 $filename.cc -DDEBUG -o $filename.exe && ./$filename.exe

elif [ $extension == cpp ]; then
  g++ -std=c++20 -DDEBUG $filename.cpp -o $filename.exe && ./$filename.exe

elif [ $extension == c ]; then
  gcc $filename.c -DDEBUG -o $filename.exe && ./$filename.exe

elif [ $extension == py ]; then
  python3 $filename.py

elif [ $extension == rs ]; then
  rustc $filename.rs -o $filename.exe && ./$filename.exe

else
  echo "NOT! compatible"
fi
