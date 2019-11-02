@echo off









set n=%/CompositeCombinatorsCore
set d=%cd%/%n%
set vr=%d%/ver

echo %vr%

set /p v=<%vr%

echo %v%

echo mklink /D "%APPDATA%/Factorio/mods/%n%_%v%" "%d%"
mklink /D "%APPDATA%/Factorio/mods/%n%_%v%" "%d%"







set n=ExtremelyUsefulCompositeCombinators
set d=%cd%/%n%
set vr=%d%/ver

echo %vr%

set /p v=<%vr%

echo %v%

echo mklink /D "%APPDATA%/Factorio/mods/%n%_%v%" "%d%"
mklink /D "%APPDATA%/Factorio/mods/%n%_%v%" "%d%"
