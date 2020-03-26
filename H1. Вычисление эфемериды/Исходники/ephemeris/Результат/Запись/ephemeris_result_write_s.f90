submodule ( ephemeris_result_m ) ephemeris_result_write_s
implicit none
     
     contains
     
     ! Процедура для записи результата в файл
     module procedure ephemeris_result_write
          
          integer(SP) :: stat ! Статусная переменная
          integer(UP) :: unit ! Номер дескриптора файла

          ! Проверка, выделена ли память под массивы результата
          if ( .not. allocated(result%dates) ) call ephemeris_result_log_error('NA_dates')
          if ( .not. allocated(result%alpha) ) call ephemeris_result_log_error('NA_alpha')
          if ( .not. allocated(result%delta) ) call ephemeris_result_log_error('NA_delta')

          ! Открытие файла
          open( newunit = unit, file = file, action = 'write', status = 'replace', iostat = stat)
          if ( stat .ne. 0_SP ) call ephemeris_result_log_error('WO', file)

          ! Запись массива дат
          write( unit, '(a)' ) 'Массив дат'
          write( unit, '(*('//RF//', 3x))' ) result%dates
          write( unit, '()')

          ! Запись массива прямых восхождений
          write( unit, '(a)' ) 'Массив прямых восхождений'
          write( unit, '(*('//RF//', 3x))' ) result%alpha
          write( unit, '()')

          ! Запись массива склонений
          write( unit, '(a)' ) 'Массив склонений'
          write( unit, '(*('//RF//', 3x))' ) result%delta

          ! Закрытие файла
          close( unit = unit, iostat = stat )
          if ( stat .ne. 0_SP ) call ephemeris_result_log_error('WC', file)
          
     end procedure ephemeris_result_write
     
end submodule ephemeris_result_write_s