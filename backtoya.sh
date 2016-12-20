#!/bin/bash

yandex-disk start
yandex-disk token -p PASSWORD USERNAME

echo ""	
echo "Привет! Этот скрипт предназначен для копирования файлов, которые ты боишься потерять, на твой Яндекс.Диск. Чтобы вывести список всех команд набери help. Удачи!"
while [ "$ANSWER" != "exit" ]
do
	FLAG=0
	FLAG0=0
	echo ""	
	echo "Текущая директория " 
	pwd
	echo ""	
	echo "Введите команду:"
	read ANSWER
	
#help
	if [[ "$ANSWER" = "help" ]]
	then
		echo ""	
		echo "Доступные команды:"
		echo ""		
		#echo "install         установка linux-клиента Яндекс.Диска"
		echo -e "\e[00;35;1mupdate\e[00m          проверка и установка обновлений"
		echo -e "\e[00;35;1mall\e[00m      	бэкап текущей директории"
		echo -e "\e[00;35;1mexit\e[00m    	выход из программы"
		echo -e "\e[00;35;1msync\e[00m            синхронизация с облаком"
		echo -e "\e[00;35;1mcd\e[00m              поменять директорию"
		echo -e "\e[00;35;1mlist\e[00m            список файлов в текущей директории"
		echo -e "\e[00;35;1mone\e[00m             скопировать файл"
		FLAG=1
	fi
#cd
	if [[ "$ANSWER" = "cd" ]]
	then
		echo "Введите адрес нужной директории"
		read ADRESS
		cd $ADRESS
		FLAG=1
	fi	
#all
	if [[ "$ANSWER" = "all" ]]
	then
		echo ""	
		echo "Копирование"
		sudo cp -R "`pwd`" /home/roman/Yandex.Disk/
		echo "Успешно!"
		echo "Синхронизация..подождите.."
		sudo chmod -R 777 /home/roman/Yandex.Disk
		yandex-disk sync /home/roman/Yandex.Disk/
		FLAG=1
	fi
#install
	#if [[ "$ANSWER" = "install" ]]
	#then
		#INFO=$(dpkg -S "*/yandex-disk")
		#if [["$INFO" != "*/yandex-disk*"]]
		#then
			#echo "deb http://repo.yandex.ru/yandex-disk/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/yandex.list > /dev/null && wget http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG -O- | sudo apt-key add - && sudo apt-get update && sudo apt-get install -y yandex-disk 
		#else
			#echo "Клиент уже был установлен"
		#fi	
	#fi
#update 
	if [[ "$ANSWER" = "update" ]]
	then 
		echo "deb http://repo.yandex.ru/yandex-disk/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/yandex.list > /dev/null && wget http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG -O- | sudo apt-key add - && sudo apt-get update && sudo apt-get install -y yandex-disk
		FLAG=1
	fi
#sync
	if [[ "$ANSWER" = "sync" ]]
	then
		yandex-disk sync
		FLAG=1
	fi
	
#list
	if [[ "$ANSWER" = "list" ]]
	then
		sudo ls -F
		FLAG=1
	fi	
#one
	if [[ "$ANSWER" = "one" ]]
	then
		read FILENAME
		PUT="`pwd`"
		SLASH="/"
		FILE="$PUT$SLASH$FILENAME"
		cp $FILE /home/roman/Yandex.Disk
		FLAG=1
	fi
#Проверка команды
	if [[ "$ANSWER" != "exit" ]]
	then
		if [ "$FLAG" -eq "$FLAG0" ]
		then
			echo "Увы, такой команды пока не существует  ¯ \ _ (ツ) _ / ¯"
		fi
	fi
done

yandex-disk stop

exit 0
