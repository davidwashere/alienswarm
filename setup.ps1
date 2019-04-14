Invoke-WebRequest -Uri "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip" -OutFile "steamcmd.zip"
Expand-Archive -Path steamcmd.zip -DestinationPath C:\steamcmd
cd C:\steamcmd

$batstart = @"
cd %~dp0

echo off 
cls 
echo Protecting srcds from crashes... 
title ASRD #1 
:srcds 
..\steamcmd\steamcmd +login anonymous +force_install_dir C:\srcds\AlienSwarmRD1 +app_update 582400 +quit
echo (%time%) Starting srcds...
start /wait /high srcds.exe -console -usegh -nomessagebox -nocrashdialog -num_edicts 8192 -game reactivedrop -heapsize 1572864 -tickrate 100 -port 27070 +map lobby +con_logfile "console.log" -maxplayers 3 +exec server.cfg
echo (%time%) WARNING: srcds closed or crashed, restarting in 20 sec.... 

echo (%time%) STARTING SERVER in 10 seconds...
ping 1.1.1.1 -n 1 -w 10000
goto srcds
"@

$batstart | Set-Content start.bat
