#---------------- Maven Uninstall--------------------------------
function uninstallMaven ($unzip_destination) {

  #starting Transcripts for logs..
  Start-Transcript -Path $mvn_logs_uninstall

  Write-Verbose "Uninstalling maven"
  Remove-Item $unzipped -Force -Recurse 

  [Environment]::SetEnvironmentVariable("MAVEN_HOME","$null","machine")
  [Environment]::SetEnvironmentVariable("Path",$env:Path + " ","Machine")

  Write-Verbose "Successfully uninstalled"

}

$path = "C:\Users\user\OneDrive\Documents\Tomcat_dependencies\dependencies.properties"
$output = Get-Content $path | ConvertFrom-StringData

$url=$output.url
$unzip_destination = $output.unzip_destination
$mvn_logs_uninstall = $output.mvn_logs_uninstall
$unzipped=$output.unzipped

uninstallMaven $unzip_destination

Stop-Transcript
