cd /d %~dp0
powershell -file  ./DeployIt.ps1 -DestinationLocation ".\\SampleDestination\\" -BackupLocation ".\\SampleDestination\\Backups\\"
pause