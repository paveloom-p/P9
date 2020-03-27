#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт, проверяющий, пусты ли директории с объектными файлами.\n"

# Определение функции для проверки директории с объектными файлами
function check_obj_dir {

     printf "\nПроверяется, пуста ли следующая директория с объектными файлами:\n"
     printf "$1\n\n"

     if [ -z "$(ls "$1")" ]; then
          printf "Директория пуста, все в порядке.\n"
     else
          printf "[!] Директория с объектными файлами не пуста.\n\n"
          exit 1
     fi

}

# Проверка
check_obj_dir "H1. Вычисление эфемериды/Объектники/"