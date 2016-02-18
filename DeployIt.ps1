#----------------------------------------------------------------------------- 
# Modified version of: http://vamsi-sharepointhandbook.blogspot.dk/2014/08/powershell-script-copy-files-from.html
#-----------------------------------------------------------------------------

Param([Parameter(Mandatory=$true)] 
      [String] 
      $DestinationLocation,
      [Parameter(Mandatory=$true)] 
      [String] 
      $BackupLocation
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
    write-host "Successfully created folder - $BackupLocation" -ForegroundColor Green
}
else
{
    write-host "Folder already exits - $BackupLocation" -ForegroundColor Blue
}

if ((Test-Path $DestinationLocation) -ne $True)
{ 
    New-Item $DestinationLocation -type directory 
    write-host "Successfully created folder - $DestinationLocation" -ForegroundColor Green
}
else
{
    write-host "Folder already exits - $DestinationLocation" -ForegroundColor Blue
}

$currentDate = Get-Date -format "MM-dd-yyyy-HHmmss"
if($currentDate -ne $null)
{
    $newFolder = $BackupLocation + $currentDate
    if ((Test-Path $newFolder) -ne $True)
    {
        New-Item $newFolder -type directory
        write-host "Successfully created backup folder-" $newFolder -ForegroundColor Green
    }
    if($newFolder -ne $null)
    {
        $removeBackupFolder = $newFolder + "\*"
        Remove-Item $removeBackupFolder -Recurse

        Copy-Item $DestinationLocation -Destination $newFolder -Recurse
        write-host "Successfully copied files to backup folder-" $newFolder -ForegroundColor Green

        $removeFolder = $DestinationLocation + "*"
        Remove-Item $removeFolder -Recurse
        write-host "Successfully removed files from folder--" $DestinationLocation -ForegroundColor Green

        #copy files from source location to destination
        $sLocation = "SampleSource\"
        Copy-Item $sLocation -Destination $DestinationLocation -Recurse
        write-host "Successfully copied files and folders to -" $DestinationLocation -ForegroundColor Green
    }    
}

Stop-Transcript
Echo Finish