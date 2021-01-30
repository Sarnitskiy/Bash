#!/bin/zsh
set -x
declare -A cnt

while read id xtra
do
    echo "Цикл id=$id"
    echo $cnt[$id]
    let "cnt[$id]++"
    echo $cnt[$id]
done
set +x