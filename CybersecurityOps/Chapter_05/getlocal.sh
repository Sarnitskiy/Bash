#!/bin/bash -
#
# getlocal.sh
#
# Описание
# Сбор основной информации о системе и сохранение в файл
#
# Использование:
# getlocal.sh < cmds.txt
#   cmds.txt - файл со списком команд для выполнения

function OsDetect()
{
    if type -t wevtutil &> /dev/null
    then
        OS=MSWin
    elif type -t scutil &> /dev/null
    then
        OS=macOS
    else
        OS=Linux
    fi
    echo $OS
}

function SepCmds()
{
    LCMD=${ALINE%%|*}
    REST=${ALINE#*|}
    WCMD=${REST%%|*}
    REST=${REST#*|}
    TAG=${REST%%|*}
    TAG=${TAG// /}

    if [[ $OSTYPE == "MSWin" ]]
    then
        CMD="$WCMD"
    else
        CMD="$LCMD"
    fi
}

function DumpInfo()
{
    printf '<systeminfo host="%s" type="%s"' "$HOSTNM" "$OSTYPE"
    printf ' date="%s" time="%s">\n' "$(date '+%F')" "$(date '+%T')"
    readarray CMDS

    for ALINE in "${CMDS[@]}"
    do
        #echo "$ALINE"

        # игнорировать комментарии
        if [[ ${ALINE:0:1} == '#' ]] ; then continue ; fi
        
        SepCmds

        if [[ ${CMD:0:3} == N/A ]]
        then
            continue
        else
            printf '<%s>\n' "$TAG"
            $CMD
            printf '</%s>\n' "$TAG"
        fi
    done

    printf "</systeminfo>\n"
}

OSTYPE=$(OsDetect)

echo "Оперерационная система: $OSTYPE"

HOSTNM=$(hostname)
TMPFILE="${HOSTNM}.info"

DumpInfo > $TMPFILE 2>&1

