#!/bin/bash -
#
# winlogs.sh
#
# Описание:
# Собирает копии файлов журнала Windows
#
# Использование:
# winlogs.sh [-z]
#	-z Заархивировать вывод
#
TGZ=0
if (( $# > 0))
then
    if [[ ${1:0:2} == '-z' ]]
    then
        TGZ=1   # флаг tgz для архивирования лог-файлов
        shift
    fi
fi

SYSNAM=$(hostname)
LOGDIR=${1:-/c/tmp_logs/${SYSNAM}_logs}
echo "Директория для сохранения логов: $LOGDIR"

mkdir -p $LOGDIR
cd ${LOGDIR} || exit 2

i=1
wevtutil el | while read ALOG
do
    ALOG="${ALOG%$'\r'}"
    echo "${ALOG}:"
    SAFNAM="${ALOG// /_}"
    SAFNAM="${ALOG//\//-}"
    echo "${SAFNAM}:"

    wevtutil epl "$ALOG" "${SYSNAM}_${SAFNAM}.evtx"

    if (( i == 10 ))
    then
        break
    fi
    echo $i
    (( i++ ))
done

if (( TGZ == 1 ))
then
    tar -czvf ${SYSNAM}_logs.tgz *.evtx
fi
