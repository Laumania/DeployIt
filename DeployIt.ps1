$SourceDir 			= "SampleSource"
$DestinationDir		= "C:\SampleDestination"
$BackupFolderName	= "Backup"
$BackupDir			= "$DestinationDir\$BackupFolderName"

Write-Output "Start deployment from '$SourceDir' --> '$DestinationDir'"


#Backup files in destination directory
Write-Output "Backup file from $DestinationDir\* --> $BackupDir"

Get-Childitem $DestinationDir\* -recurse -exclude $BackupFolderName | %{
				Write-Output "Backup file $_ ->> $BackupDir\"
                Copy-Item -Path $_ -Destination $BackupDir\}

#Copy-Item $DestinationDir\* $BackupDir -exclude $BackupFolderName -recurse

#Remove all files from destination
Remove-Item $DestinationDir\* -exclude $BackupFolderName -recurse

#Copy all files from source
Copy-Item $SourceDir\* $DestinationDir -recurse