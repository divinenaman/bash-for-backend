#!/bin/bash

db=$1
backup_dir=$2

if [ -z $db ] || [ -z $backup_dir ]
then
  echo "enter db name and backup dir as arguments"
else

  recent=$(ls $backup_dir -At | head -1)
  
  # create backup
  pg_dump $db > $backup_dir/temp.sql
  diff=1
  
  if [[ -z $recent ]]; then diff=0; else diff=$(./check-file-hash.sh  $backup_dir/temp.sql  $backup_dir/$recent); fi

  if [[ $diff == 0 ]]
  then
    timestamp=$(date +%s)
    date=$(date +'%d_%m_%Y')
    filename="$timestamp""_$date""_data.sql"

    mv $backup_dir/temp.sql $backup_dir/$filename
    echo "backup created"
  else
    echo "no new changes, backup not needed"
    rm $backup_dir/temp.sql
  fi
fi

