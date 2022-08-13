#!/bin/bash

f1=$1
f2=$2

if [ -z $f1 ] || [ -z $f2 ]
then
  echo "enter 2 file path as arguments"

else
  h1=$(md5sum $f1 | awk '{print $1}')
  h2=$(md5sum $f2 | awk '{print $1}')
  
  if [[ $h1 == $h2 ]]
  then
    echo 1;
  else
    echo 0;
  fi
fi

