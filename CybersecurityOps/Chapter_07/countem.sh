#!/bin/bash -
#
# countem.sh
#
# Описание:
# Подсчет количества экземпляров элемента
#
# Использование:
# countem.sh < inputfile
#
declare -A cnt  # ассоциативный массив

while read id xtra
do
    let cnt[$id]++
done

for id in ${!cnt[@]}
do
    printf '%d %s\n' "${cnt[${id}]}" "$id" 
done