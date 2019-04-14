Invoke-WebRequest -Uri "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip" -OutFile "steamcmd.zip"
Expand-Archive -Path steamcmd.zip -DestinationPath C:\steamcmd
cd C:\steamcmd
