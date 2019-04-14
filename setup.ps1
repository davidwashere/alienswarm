Invoke-WebRequest -Uri "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip" -OutFile "steamcmd.zip"
Expand-Archive -Path steamcmd.zip -DestinationPath C:\steamcmd

C:\steamcmd\steamcmd +login anonymous +force_install_dir C:\srcds\alienswarmrd1 +app_update 582400 +quit


# ==================================================================
# ==================================================================
$batstart = @"
cd %~dp0

echo off 
cls 
echo Protecting srcds from crashes... 
title Alien Swarm Reactive Drop Dedicated Server
:srcds 
..\steamcmd\steamcmd +login anonymous +force_install_dir C:\srcds\alienswarmrd1 +app_update 582400 +quit
echo (%time%) Starting srcds...
start /wait /high srcds.exe -console -usegh -nomessagebox -nocrashdialog -num_edicts 8192 -game reactivedrop -heapsize 1572864 -tickrate 100 -port 27070 +map lobby +con_logfile "console.log" -maxplayers 3 +exec server.cfg
echo (%time%) WARNING: srcds closed or crashed, restarting in 20 sec.... 

echo (%time%) STARTING SERVER in 10 seconds...
ping 1.1.1.1 -n 1 -w 10000
goto srcds
"@

# ==================================================================
# ==================================================================
$cfgautoexec = @"
// server bandwidth settings

sv_minrate 36864
sv_maxrate 36864

sv_minupdaterate 35
//sv_maxupdaterate 99.98 //99.999996185302727269 //100 ticks
sv_maxupdaterate 59.98 //59.99999809265136363519

sv_mincmdrate 35
sv_maxcmdrate 59.98 //100 for 100ticks

net_splitpacket_maxrate 786432
net_splitrate 2
net_maxcleartime 0.001

sv_client_cmdrate_difference 20 
sv_max_queries_sec 3 
sv_max_queries_sec_global 30 
sv_max_queries_window 15
//
// server client-side lag control settings
sv_client_max_interp_ratio 8
//sv_client_min_interp_ratio 2 //1.9999999403953551136 //100ticks
sv_client_min_interp_ratio 2 //1.99999982118606578496

sv_client_predict 1
//
// server engine settings
asw_max_saves 600
sv_autosave 0
sv_allow_wait_command 0
sv_allow_lobby_connect_only 1
sv_forcepreload 1
sv_hibernate_ms 50
sv_hibernate_ms_vgui 250
sv_hibernate_postgame_delay 5
sv_hibernate_when_empty 1
//
// server log settings
log off
con_timestamp 1
sv_logbans 1
sv_logblocks 1
sv_logecho 0
sv_logfile 1
sv_logflush 0
sv_logsdir logs
sv_log_onefile 1
//
// server content protection settings
sv_pure 2
sv_pure_kick_clients 1
sv_pure_trace 1
//
// server remote connection protection settings
sv_rcon_banpenalty 300
sv_rcon_log 1
sv_rcon_maxfailures 2
sv_rcon_minfailures 1
sv_rcon_minfailuretime 3600
//
// sound engine update
snd_updateaudiocache
"@

# ==================================================================
# ==================================================================
$hostname = Read-Host -Prompt 'Server Host Name'
$password = Read-Host -Prompt 'Server RCON Password'

$cfgserver = @"
hostname "$hostname" 
rcon_password $password

asw_marine_death_cam_slowdown 0
rd_override_allow_rotate_camera 1
rd_ready_mark_override 1
sv_steamgroup 3885128
"@

# ==================================================================
# ==================================================================
$cfgnewmapsettings = @"

fps_max 0
// for server to be visible in Dedicated server list
setmaster add hl2master.steampowered.com:27011
"@

# ==================================================================
# ==================================================================
# New-Item -ItemType Directory -Path C:\srcds\alienswarmrd1\

$batstart | Set-Content C:\srcds\alienswarmrd1\start.bat
$cfgautoexec | Set-Content C:\srcds\alienswarmrd1\reactivedrop\cfg\autoexec.cfg
$cfgserver | Set-Content C:\srcds\alienswarmrd1\reactivedrop\cfg\server.cfg

$cfgnewmapsettings | Out-File -FilePath "C:\srcds\alienswarmrd1\reactivedrop\cfg\newmapsettings.cfg" -Append



