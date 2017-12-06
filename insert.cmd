@echo off

setlocal enabledelayedexpansion
cls

if "%4"=="" goto usage

set tablename=%1
set datafile=%2
set records=%3
set pk_seq=%4

if exist %tablename%.sql del %tablename%.sql

REM Check number of lines in data file and assign the number (minus header row) to the NR variable like in AWK
for /f %%a in ('FINDSTR /R /N /C:"^.*" %datafile% ^| find /c ":"') do set /a NR=%%a-1
echo Liczba wierszy w pliku z danymi (%datafile%): %NR%

set l=1
:head_to_array
for /f "tokens=%l% delims=;" %%A in (%datafile%) do (
  set field=%%A
  set f[%l%]=!field:~1!
  goto next_token
)
:next_token
set /a l+=1
if %l% LEQ %NR% goto head_to_array

set record=1
:next_record
REM Generate record to .sql file
echo Rekord: %record% z %records%

echo INSERT INTO HRS_SCH.%tablename%>> %tablename%.sql
echo VALUES (>> %tablename%.sql
if %4==1 (
  echo nextval('HRS_SCH.%tablename%_seq'^),>> %tablename%.sql
) ELSE (
  REM bez PK with sequence
)

set row_number=1
:next_row
REM Skip processed rows, get next row to the variable and break loop
for /f "skip=%row_number% delims=" %%c IN (%datafile%) Do (
  set line=%%c
  goto :next
)

:next
REM Count fields in the current row and assign the number to the NF variable like in AWK
set NF=0
REM Assign row variable to line variable, because we need unchanged line variable later
set row=%line%
:repeat
set "oldrow=%row%"
set "row=%row:*;=%"
set /a NF+=1
if not "%row%" == "%oldrow%" goto :repeat

REM Set a random field in the range of 1 to the number of fields in a current row
set /a rand_field=(%RANDOM%*%NF%/32768)+1

if "!f[%row_number%]!"=="Pass" set rand_field=%record%
if "!f[%row_number%]!"=="Start_date" set rand_field=%record%
if "!f[%row_number%]!"=="End_date" set rand_field=%record%
if "!f[%row_number%]!"=="Agreed" set rand_field=%record%
if "!f[%row_number%]!"=="Disagree_reason" set rand_field=%record%

REM Get random field from current row
for /f "tokens=%rand_field% delims=;" %%d in ("%line%") do (
  echo !f[%row_number%]!: %%d  # NF=%NF%, Rand NF=%rand_field%
  echo %%d,>> %tablename%.sql
) 

REM Increment row number, if this is the last row, finish the record, otherwise process the row
set /a row_number+=1
if %row_number% GTR %NR% goto end_record
goto :next_row

:end_record
echo );>> %tablename%.sql

REM Increment record number, if this is the last record, end script, otherwise process the record
set /a record+=1
if %record% GTR %records% goto end
goto :next_record

:usage
echo syntax: %0 table_name data_file number_of_records PK_sequence
echo example: %0 Users usersdata.txt 10 1

:end
endlocal