#!/bin/bash -
#
# Поиск в фаловой системе файлов указанного типа
# Выводит путь, когда найден
#
# Использование
# typesearch.sh [-c dir] [-i] [-R|r] <pattern> <path>
#	-c Копировать найденные файлы в каталог
#	-i Игнорировать регистр
#	-R|r Рекурсивный поиск подкаталогов
#	<pattern> Шаблон типа файла для поиска
#	<path> Путь для начала поиска
#

DEEPORNOT="-maxdepth 1"		# только текущий каталог; по умолчанию

# анализ аргументов:
while getopts 'c:irR' opt
do
	#echo $?
	#echo $opt
	#echo $OPTARG
	case ${opt} in
		c) # копировать найденные файлы в указанный каталог
			COPY=YES
			DESTDIR="$OPTARG"
			;;
		i) # игнорировать регистр при поиске
			CASEMATCH='-i'
			;;
		[rR]) # рекурсивно
			unset DEEPORNOT
			;;
		*) # неизвестный/неподдерживаемый вариант
		   # при получении ошибки mesg от getops просто выйти
		   exit 2
	esac
done

shift $((OPTIND - 1))

PATTERN=${1:-PDF document}
STARTDIR=${2:-.}
echo $STARTDIR

find $STARTDIR $DEEPORNOT -type f | while read FN
do
	file $FN | egrep -q $CASEMATCH "$PATTERN"
	if (( $? == 0 )) # найден один
	then
		echo $FN
		if [[ $COPY ]]
		then
			cp -p $FN $DESTDIR
		fi
	fi
done
