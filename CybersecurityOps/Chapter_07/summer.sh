#!/bin/bash -
#
# summer.sh
#
# Описание:
# суммировать итоговые значения поля 2 
# для каждого уникального поля 1
#
# Использование:
# summer.sh < inputfile
#
declare -A cnt  # ассоциативный массив

while read id count
do
    let cnt[$id]+=$count
done

for id in ${!cnt[@]}
do
    printf '%-15s %8d\n' "${cnt[${id}]}" "$id" 
done