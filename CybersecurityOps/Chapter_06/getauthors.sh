#!/bin/bash
#
# скрипт извлекает имена и фамилии всех авторов
# из файла book.json
#
echo "Команда egrep:"
egrep -o '"(firstName|lastName)": ".*"' book.json \
  | cut -d " " -f2 \
  | tr -d '\"'

echo -e "\nКоманда grep:"
grep -o '"\(firstName\|lastName\)": ".*"' book.json \
  | cut -d " " -f2 \
  | tr -d '\"'