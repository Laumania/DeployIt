#----------------------------------------------------------------------------- 
# Modified version of: http://vamsi-sharepointhandbook.blogspot.dk/2014/08/powershell-script-copy-files-from.html
#-----------------------------------------------------------------------------

Param([Parameter(Mandatory=$true)] 
      [String] 
      $DestinationLocation,
      [Parameter(Mandatory=$true)] 
      [String] 
      $BackupLocation,
      [Parameter(Mandatory=$true)] 
      [String] 
      $SourceLocation
)

function Get-ScriptDirectory
{
 $Invocation = (Get-Variable MyInvocation -Scope 1).Value
 Split-Path $Invocation.MyCommand.Path
}

$currentPhysicalPath = Get-ScriptDirectory

$logfile=$currentPhysicalPath + "\deployIt.log"

Start-Transcript $logfile

if ((Test-Path $BackupLocation) -ne $True)
{ 
    New-Item $BackupLocation -type directory 
    write-host "Created backup folder: $BackupLocation" -ForegroundColor Green
}
else
{
    write-host "Folder already exits: $BackupLocation" -ForegroundColor Blue
}

if ((Test-Path $DestinationLocation) -ne $True)
{ 
    New-Item $DestinationLocation -type directory 
    write-host "Created destination folder: $DestinationLocation" -ForegroundColor Green
}
else
{
    write-host "Folder already exits: $DestinationLocation" -ForegroundColor Blue
}

$currentDate = Get-Date -format "HHmmss" #"MMddyyyyHHmmss"
if($currentDate -ne $null)
{
    $actualBackupFolder = "$BackupLocation\$currentDate"
    if ((Test-Path $actualBackupFolder) -ne $True)
    {
        New-Item $actualBackupFolder -type directory
        write-host "Created actual backup folder: $actualBackupFolder" -ForegroundColor Green
    }

    if($actualBackupFolder -ne $null)
    {
        $removeBackupFolder = $actualBackupFolder + "\\*"
        Remove-Item $removeBackupFolder -Recurse
        write-host "Deleted all files in destination $removeBackupFolder" -ForegroundColor Green

        $destinationPathFull = $DestinationLocation +"\*"
        $backupPathFull = $actualBackupFolder +"\\"
        write-host "Start backing up $destinationPathFull --> $backupPathFull" -ForegroundColor Green
        
        Copy-Item $destinationPathFull -Destination $backupPathFull -exclude Backups -Recurse
        write-host "Successfully copied files to backup folder-" $actualBackupFolder -ForegroundColor Green

        $removeFolder = $DestinationLocation + "*"
        Remove-Item $removeFolder -exclude Backups -Recurse
        write-host "Successfully removed files from folder: $DestinationLocation" -ForegroundColor Green

        #copy files from source location to destination
        Copy-Item $SourceLocation -Destination $DestinationLocation -Recurse
        write-host "Successfully copied files and folders to -" $DestinationLocation -ForegroundColor Green
    }    
}

Stop-Transcript
Echo Finish