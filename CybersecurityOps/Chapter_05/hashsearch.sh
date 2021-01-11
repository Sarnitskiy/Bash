#!/bin/bash -
#
# hashsearch.sh
#
# Описание:
# В указанном каталоге выполняем рекурсивный поиск 
# файла по заданному SHA-1
#
# Использование:
# hashsearch.sh <hash> <directory>
#   hash - значение хеша SHA-1 разыскиваемого файла
#   directory - каталог для поиска

function getcommand ()
{
    if type -t sha1sum &> /dev/null
    then
        SHA=sha1sum
    elif type -t shasum &> /dev/null
    then
        SHA=shasum
    else
        exit 2
    fi
}

function mkabspath ()
{
    if [[ $1 == /* ]]
    then
        ABS=$1
    else
        ABS="$(pwd)/$1"
    fi

    ABS=${ABS/\/.\//\/}
}

HASH=${1}
DIR=${2:-.} # если не задана директория используем текущий каталог

# echo $HASH
# echo $DIR

find $DIR -type f |
while read fn
do
    # echo $fn

    getcommand

    THISONE=$($SHA "$fn")
    THISONE=${THISONE%% *}

    if [[ $THISONE == $HASH ]]
    then
        mkabspath "$fn"
        echo "Совпадение c $ABS"
    fi
done

