@ECHO off

SET cnfFile=C:\Users\Justin\Documents\Database\Configs\classicDb.cnf
SET databaseName=ClassicDatabase
ECHO CNF File: %cnfFile%
ECHO Database: %databaseName%

REM Create the database
call:runMySqlCommand "CREATE DATABASE IF NOT EXISTS %databaseName%;"

REM Create the Tables
call:runMySqlFile "./Tables/Planet.sql"
call:runMySqlFile "./Tables/Map.sql"
call:runMySqlFile "./Tables/ItemType.sql"
call:runMySqlFile "./Tables/Item.sql"
call:runMySqlFile "./Tables/Armor.sql"
call:runMySqlFile "./Tables/Weapon.sql"
call:runMySqlFile "./Tables/MonsterType.sql"
call:runMySqlFile "./Tables/Monster.sql"
call:runMySqlFile "./Tables/MapDrop.sql"
call:runMySqlFile "./Tables/MonsterDrop.sql"
call:runMySqlFile "./Tables/MonsterSpawn.sql"


REM Create the Views

REM Create the Functions

REM Create the Stored Procedures

REM Insert the initial data
call:runMySqlFile "./Data/PlanetData.sql"
call:runMySqlFile "./Data/MapData.sql"
call:runMySqlFile "./Data/ItemTypeData.sql"
call:runMySqlFile "./Data/ItemData.sql"
call:runMySqlFile "./Data/ArmorData.sql"
call:runMySqlFile "./Data/WeaponData.sql"
call:runMySqlFile "./Data/MonsterTypeData.sql"
call:runMySqlFile "./Data/MonsterData.sql"
call:runMySqlFile "./Data/MapDropData.sql"
call:runMySqlFile "./Data/MonsterDropData.sql"

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