@echo off
setlocal
if not exist out mkdir out
javac -d out src\simulator\*.java
if errorlevel 1 goto :eof
jar --create --file LAB211Simulator.jar --main-class simulator.ShopeeSimulatorMain -C out .
if errorlevel 1 goto :eof
java -jar LAB211Simulator.jar config.properties
endlocal
