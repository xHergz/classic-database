@ECHO off

SET cnfFile=./classicDb.cnf
SET databaseName=ClassicDatabase
ECHO CNF File: %cnfFile%
ECHO Database: %databaseName%

REM Create the database
call:runMySqlCommand "CREATE DATABASE IF NOT EXISTS %databaseName%;"

REM Create the Tables
call:runMySqlFile "./Tables/SystemConfiguration.sql"


REM Create the Views

REM Create the Functions

REM Create the Stored Procedures

REM Insert the initial data
call:runMySqlFile "./Data/SystemConfigurationData.sql"

ECHO Press any key to close...
SET /p closeWindow=

goto:eof

:runMySqlCommand
ECHO Executing command: %~1
mysql --defaults-extra-file=%cnfFile% -e "%~1"
goto:eof

:runMySqlFile
ECHO Running file: %~1
mysql --defaults-extra-file=%cnfFile% %databaseName% < "%~1"
goto:eof