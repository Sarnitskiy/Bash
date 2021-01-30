#!/usr/bin/env bash
#
# histogram_plain.sh
#
# Описание:
# создание горизонтальной гистограммы с указанными данными
#
# Использование:
# ./histogram_plain.sh
# формат ввода: label value
# cut -d ' ' -f1,10 access.log | bash summer.sh | bash histogram_plain.sh
#

source ./pr_bar.sh

declare -a RA_key RA_val
declare -i max ndx
max=0
MAXBAR=50   # размер самой длинной строки

ndx=0
while read labl val
do
    RA_key[$ndx]=$labl
    RA_val[$ndx]=$val
    # сохранить наибольшее значение для масштабирования
    (( val > max )) && max=$val
    let ndx++
done

# масштабировать и вывести
for (( j = 0; j < ndx; j++ ))
do
    printf '%-20.20s ' ${RA_key[$j]}
    pr_bar ${RA_val[$j]} $max
done