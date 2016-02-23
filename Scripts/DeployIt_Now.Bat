cd /d %~dp0
powershell -file  ./DeployIt.ps1 -SourceLocation "..\\SampleSource\\" -DestinationLocation ".\\SampleDestination\\" -BackupLocation ".\\SampleDestination\\Backups\\"
pause