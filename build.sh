#!/bin/sh

sha1sum contents/* | sha1sum > temp

if diff hash.txt temp > /dev/null; then
  echo "Hashes are the same. No need to rebuild!"
  mv temp hash.txt
else
  echo "Hashes are different. Rebuilding!"
  mv temp hash.txt
  
  for i in $(seq 1 $1); do
    echo "Compiling LaTeX (silently...)"
    pdflatex --shell-escape main.tex > temp.log
    rm temp.log
  done
  
  rm */*.aux
  rm *.aux
  rm *.log
  rm *.out
fi

