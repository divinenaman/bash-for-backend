#!/bin/bash

for n in "$@"
do
    if [[ $n == "all" ]]
    then
        read -p "kill all docker container [y|n]: " c
        if [[ $c == 'y' || $c == 'yes' ]]
        then
            containers=$(docker ps | tr -s " " | cut -d ' ' -f 1 | tail -n +2)
            while read i 
                do 
                if [[ -z $i ]] 
                then 
                    exit 0 
                else 
                    sudo docker kill "$i" 
                fi
            done <<< `echo "$containers"`
            exit 0
        fi

    else
        read -p "kill $n docker container [y|n]: " c
        if [[ $c == 'y' || $c == 'yes' ]]
        then
            sudo docker kill "$n"
        fi
    fi
done 