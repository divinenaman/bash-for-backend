#!/bin/bash

for p in "$@"
do
  if [[ $p =~ ^[0-9]+$ ]]
  then
    out=$(netstat -nlp | grep -w $p | awk '{print $7}');
    if [ -z "$out" ]
    then
      echo "no service running on port: $p"
    else
      echo "service running on port $p: $out"
      read -p "kill [y|n]: " c
      if [[ $c == 'y' || $c == 'yes' ]]
      then
        pid=$(echo "$out" | awk -F "/" '{print $1}')
        kill -9 "$pid" 
      fi
    fi
  fi
done
  
