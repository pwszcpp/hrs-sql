@echo off

setlocal enabledelayedexpansion
cls

if "%3"=="" goto usage

set tablename=%1
set datafile=%2
set records=%3

if exist %tablename%.sql del %tablename%.sql

REM Check number of lines in data file and assign the number to the NR variable like in AWK
for /f %%a IN ('FINDSTR /R /N /C:"^.*" %datafile% ^| find /c ":"') Do set NR=%%a
echo Liczba wierszy w pliku z danymi (%datafile%): %NR%

set record=1
:next_record
REM Generate record to .sql file
echo(
echo Rekord: %record% z %records%

echo INSERT INTO HRS_SCH.%tablename%>> %tablename%.sql
echo VALUES (>> %tablename%.sql
echo nextval('HRS_SCH.%tablename%_seq'),>> %tablename%.sql

set row_number=1
:next_row
echo Wiersz: %row_number% z %NR%
REM Set the skip parameter for the "for" loop (how many rows to skip in the current loop)
set /a row_to_skip=%row_number%-1
if %row_to_skip%==0 (set skip="delims=") else set skip="skip=%row_to_skip% delims="

REM Skip processed rows, get next row to the variable and break loop
for /f %skip% %%c IN (%datafile%) Do (
  set line=%%c
  echo Zawartosc wiersza: !line!  
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
echo Liczba pol w wierszu: %NF%

REM Set a random field in the range of 1 to the number of fields in a current row
set /a rand_field=(%RANDOM%*%NF%/32768)+1

if %row_number%==2 (
  set rand_field=%record%
  echo Nr pola w wierszu: !rand_field!
) ELSE (
  echo Pseudolosowy nr pola w wierszu: %rand_field%
)

REM Get random field from current row
for /f "tokens=%rand_field% delims=;" %%d in ("%line%") do (
  if %row_number%==2 (
    echo Pole: %%d
    echo %%d,>> %tablename%.sql
  ) ELSE (
    echo Wylosowane pole: %%d
    echo %%d,>> %tablename%.sql
  )
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
echo syntax: %0 table_name data_file number_of_records
echo example: %0 Users usersdata.txt 10

:end
endlocal