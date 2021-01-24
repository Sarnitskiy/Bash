#!/bin/zsh

while read id xtra
do
    echo "Цикл id=$id"
    echo $cnt[$id]
    let "cnt[$id]++"
    echo $cnt[$id]
done