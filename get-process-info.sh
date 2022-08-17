
for p in "$@"
    do        
        out=$(ps -o pid,user,%mem,command -p $p | tail -n 1)

        if [[ -z $out ]]
        then
            echo "PID: $p not found"
        else
            pid=$(echo $out | awk '{print $1}')
            user=$(echo $out | awk '{print $2}')
            mempercent=$(echo $out | awk '{print $3}')
            cmd=$(echo $out | awk '{$1=$2=$3="";print $0}')

            echo "PID: $pid"
            echo "USER: $user"
            echo "MEM PERCENT: $mempercent"
            echo "COMMAND: $cmd"

            kb=$(pmap $pid | tail -n 1 | awk '{print $2}')    
            
            if [ -z $kb ]
            then
                echo "no mem info"
            else 
                t=${kb::-1}

                if [[ $t =~ ^[0-9]+$ ]]
                then

                    mb=$(echo "scale=2; ($t / 1024)" | bc)"MB"
                    gb=$( echo "scale=2; ($t / 1024^2)" | bc)"GB"
                    
                    echo "MEMORY (KB): $kb"
                    echo "MEMORY (MB): $mb"
                    echo "MEMORY (GB): $gb"
                fi
            fi
            echo
        fi
    done