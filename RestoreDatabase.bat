@ECHO off

SET cnfFile=C:\Users\Justin\Documents\Database\Configs\classicDb.cnf
SET databaseName=ClassicDatabase
SET backupPath=C:\Users\Justin\Documents\Database\Backups\
ECHO CNF File: %cnfFile%
ECHO Database: %databaseName%
SET /p backupDate="Backup Date (YYYY-MM-DD): "

mysql --defaults-extra-file=%cnfFile% < "%backupPath%%databaseName%_%backupDate%.sql"

ECHO Press any key to close...
SET /p closeWindow=