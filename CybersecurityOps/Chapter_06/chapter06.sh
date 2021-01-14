#!/bin/bash
#
# cut
#  -d';' задать разделитель
#  -f1   номер возвращаемой позиции
#
echo "Отобразить поле PID"
cut -d';' -f2 tasks.txt

# join
#  -t\; задать разделитель
#  -1 2   номер поля для соединения
#
echo -e "\nСоединить файлы"
join -1 2 -2 2 -t\; tasks.txt procowner.txt