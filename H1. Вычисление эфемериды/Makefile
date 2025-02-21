
     ## Это шаблон* make-файла для компиляции программ.

     ## * Изменен для данного проекта.

     ## Репозиторий на GitHub: https://github.com/Paveloom/B1
     ## Документация: https://www.notion.so/paveloom/B1-fefcaf42ddf541d4b11cfcab63c2f018

     ## Версия релиза: 2.1.3
     ## Версия документации: 2.1.0

     ## Автор: Павел Соболев (http://paveloom.tk)

     ## Для корректного отображения содержимого
     ## символ табуляции должен визуально иметь
     ## ту же длину, что и пять пробелов.

     # Настройки make-файла

     ## Имя координатора
     make_name := make

     ## Указание оболочки
     SHELL := /bin/bash

     ## Указание make-файлу выполнять все правила в одном вызове оболочки
     .ONESHELL :

     ## Заглушка на вывод сообщений указанными правилами
     ## (без указания имён подавляет вывод со стороны make-файла у всех правил)
     .SILENT :

     ## Правила-псевдоцели

     .PHONY : result, result-r, result-d, result-c, clean

     ## Правило, выполняющееся при вызове координатора без аргументов
     ALL : result

     # Настройки компиляции программ

     ## Компилятор
     comp := gfortran

     ## Флаг для указания директории для хранения .mod файлов
     module_flag := -J

     ## Расширение исходных файлов
     pattern := f90

     ## Режим отладки (при значении true использует флаги opt_debug, при другом значении — opt_production)
     debugging := false

     ## Флаги для отладки
     opt_debug := -Og -g -Wall -Wextra -Warray-temporaries -Wcharacter-truncation -Wconversion-extra \
                  -Wimplicit-interface -Wimplicit-procedure -Wintrinsics-std \
                  -Wreal-q-constant -Wsurprising -Wunderflow -Walign-commons \
                  -Wfunction-elimination -Wrealloc-lhs -Wrealloc-lhs-all \
                  -fbacktrace -ffree-line-length-0 -fcheck=all \
                  -ffpe-trap=invalid,zero,overflow,underflow -pedantic-errors -std=f2018

     ## Флаги для финальной сборки
     opt_production := -Ofast -ffree-line-length-0

     ## Имя главной программы
     main_name := main

     ## Использовать input файл?
     use_input := false

     ## Использовать output файл?
     use_output := false

     ## Сохранять собранную программу при очистке?
     save_main := false

     ## Директория с исходными файлами (всегда в окончании прямой слеш; точка-слеш, если хранить в текущей директории)
     source_path := Исходники/

     ## Указание поддиректорий в директории с исходными файлами (всегда в окончании прямой слеш), относящихся к модулю
     module_subs := Вход/ Вход/Ошибки/ Вход/Считывание/ Вход/Освобождение/ \
                    Действия/ Действия/Вычисление/ Действия/Ошибки/ \
                    Результат/ Результат/Ошибки/ Результат/Освобождение/ Результат/Запись/ \
                    Вспомогательные/Освобождение/ Вспомогательные/Вычисление/ \
                    Конвертация/ Конвертация/Процедуры/

     ## Указание всех поддиректорий в директории с исходными файлами (всегда в окончании прямой слеш)
     subs := ephemeris/ $(addprefix ephemeris/, $(module_subs))

     ## Директория с объектными файлами (всегда в окончании прямой слеш; точка-слеш, если хранить в текущей директории)
     obj_path := Объектники/

     ## Правила-зависимости (при необходимости)

     $(obj_path)$(main_name).o : $(obj_path)ephemeris.o

          # API модуля
          $(obj_path)ephemeris.o : $(obj_path)ephemeris_input_m.o $(obj_path)ephemeris_do_m.o \
                                   $(obj_path)ephemeris_result_m.o

               # Вспомогательные процедуры
               $(obj_path)ephemeris_deallocate_s.o : $(obj_path)ephemeris.o

               # Вспомогательная процедура для вычисления эфемериды
               $(obj_path)ephemeris_calculate_s.o : $(obj_path)ephemeris.o

               # Входные данные
               $(obj_path)ephemeris_input_m.o : $(obj_path)prec_m.o

                    # Считывание
                    $(obj_path)ephemeris_input_read_s.o : $(obj_path)ephemeris_input_m.o

                    # Освобождение памяти
                    $(obj_path)ephemeris_input_deallocate_s.o : $(obj_path)ephemeris_input_m.o

                    # Вывод ошибок
                    $(obj_path)ephemeris_input_log_error_s.o : $(obj_path)ephemeris_input_m.o

               # Действия
               $(obj_path)ephemeris_do_m.o : $(obj_path)prec_m.o $(obj_path)ephemeris_input_m.o \
                                             $(obj_path)ephemeris_result_m.o $(obj_path)ephemeris_conversion_m.o

                    # Вычисление эфемериды (с дополнительным выводом)
                    $(obj_path)ephemeris_do_calculate_verbose_s.o : $(obj_path)ephemeris_do_m.o

                    # Вычисление эфемериды (без дополнительного вывода)
                    $(obj_path)ephemeris_do_calculate_non_verbose_s.o : $(obj_path)ephemeris_do_m.o

                    # Вывод ошибок
                    $(obj_path)ephemeris_do_log_error_s.o : $(obj_path)ephemeris_do_m.o

               # Результат
               $(obj_path)ephemeris_result_m.o : $(obj_path)prec_m.o $(obj_path)ephemeris_conversion_m.o

                    # Освобождение памяти
                    $(obj_path)ephemeris_result_deallocate_s.o : $(obj_path)ephemeris_result_m.o

                    # Вывод ошибок
                    $(obj_path)ephemeris_result_log_error_s.o : $(obj_path)ephemeris_result_m.o

                    # Запись результата
                    $(obj_path)ephemeris_result_write_s.o : $(obj_path)ephemeris_result_m.o

               # Конвертация
               $(obj_path)ephemeris_conversion_m.o : $(obj_path)prec_m.o

                    # Функция для конвертации из радианной меры в градусную (с форматированием)
                    $(obj_path)ephemeris_conversion_DD_s.o : $(obj_path)ephemeris_conversion_m.o

                    # Функция для конвертации из радианной меры в часовую
                    $(obj_path)ephemeris_conversion_DMS_s.o : $(obj_path)ephemeris_conversion_m.o

     # Определение флагов компилятора

     ifeq (true, $(debugging))
          opt := $(opt_debug)
     else
          opt := $(opt_production)
     endif

     # Распределение исходных файлов по переменным

     ## Директории, где искать исходные файлы
     VPATH := $(source_path) $(addprefix $(source_path), $(subs))

     ## Получение полного списка исходных файлов

     allpattern := $(addsuffix *.$(pattern), $(VPATH))
     source := $(wildcard $(allpattern))

     main_source := $(filter %$(main_name).$(pattern), $(source))

     ## Смена пути исходных файлов

     obj_path_source := $(addprefix $(obj_path), $(notdir $(source)))

     ## Получение списков .mod файлов и .o файлов, связанных с модулями. Объектный
     ## файл для главной программы записан в переменную obj_main для сохранения
     ## общности семантики.

     mod := $(filter-out %$(main_name).mod, $(patsubst %.$(pattern), %.mod, $(obj_path_source)))
     obj_mod := $(patsubst %.mod, %.o, $(mod))

     obj_main := $(patsubst %.$(pattern), %.o, $(filter %$(main_name).$(pattern), $(obj_path_source)))

     # Блок правил для компиляции объектных файлов

     $(main_name) : $(obj_main) $(obj_mod)
	               $(comp) $(opt) $^ -o $@

     $(obj_path)%.o : %.$(pattern)
	                 $(comp) -c $(opt) $(module_flag) $(obj_path) $< -o $(addprefix $(obj_path), $(subst .$(pattern),.o, $(notdir $<)))

     $(obj_main) : $(main_source)
	              $(comp) -c $(opt) $(module_flag) $(obj_path) $< -o $(addprefix $(obj_path), $(notdir $@))

     # Блок правил для сборки программы

     input :
	        touch input

     result : $(main_name)
	         if [ "true" = "$(use_input)" ]; then
	              $(make_name) input;
	              if [ "true" = "$(use_output)" ]; then
	                   time ./$< < input > output;
	              else
	                   time ./$< < input;
	              fi
	         else
	              if [ "true" = "$(use_output)" ]; then
	                   time ./$< > output;
	              else
	                   time ./$<;
	              fi
	         fi

     result-r :
	           if [ "true" != "$(use_output)" ]; then
	                echo; echo "Вы не можете использовать это правило, пока значение переменной use_output != true."; echo;
	                exit 1;
	           fi
	           $(make_name) result
	           cat output

     result-d :
	           $(make_name) result
	           $(make_name) clean

     result-c :
	           if [ "true" != "$(use_output)" ]; then
	                echo; echo "Вы не можете использовать это правило, пока значение переменной use_output != true."; echo;
	                exit 1;
	           fi
	           $(make_name) result-r
	           $(make_name) clean

     # Правило для очистки

     clean :
	        if [ "true" = "$(save_main)" ]; then
	             rm -f $(obj_main) $(obj_mod) $(obj_path)*.smod $(mod);
	        else
	             rm -f $(obj_main) $(obj_mod) $(obj_path)*.smod $(mod) $(main_name);
	        fi
