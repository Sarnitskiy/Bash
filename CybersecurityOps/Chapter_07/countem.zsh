#!/bin/zsh
#
# countem.zsh
#
# Описание:
# Подсчет количества экземпляров элемента
#
# Использование:
# countem.zsh < inputfile
# cut -d ' ' -f1 access.log | /bin/zsh countem.sh
#
# перебор ключей ассоциативного массива в zsh: ${(k)array}
# в zsh выражение let "cnt[$id]++" обязательно брать в кавычки

declare -A cnt  # ассоциативный массив

while read id xtra
do
    let "cnt[$id]++"
done

for id in ${(k)cnt}
do
    printf '%d %s\n' "${cnt[${id}]}" "$id" 
done