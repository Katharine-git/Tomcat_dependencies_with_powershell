#---------------- Maven Uninstall--------------------------------
function uninstallMaven ($unzip_destination) {

  #starting Transcripts for logs..
  Start-Transcript -Path $mvn_logs_uninstall

  Write-Verbose "Uninstalling maven"
  Get-ChildItem $path | Remove-Item -Force -Recurse -confirm:$false

  [Environment]::SetEnvironmentVariable("MAVEN_HOME","$null","machine")
  [Environment]::SetEnvironmentVariable("Path",$env:Path + " ","Machine")

  Write-Verbose "Successfully uninstalled"

}

$path = "C:\Users\user\OneDrive\Documents\JAVA\dependencies.properties"
$output = Get-Content $path | ConvertFrom-StringData

$unzip_destination = $output.unzip_destination
$mvn_logs_uninstall = $output.mvn_logs_uninstall

uninstallMaven $unzip_destination

Stop-Transcript
