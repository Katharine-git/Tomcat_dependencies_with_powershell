#--------------------install Maven----------------------------------
function installmaven ($url,$destination,$unzip_destination) {

  #Starting Transcription for logs"
  Start-Transcript -Path $mvn_logs_install

  # Installing Maven    
  Write-Host "downloading started"
  Invoke-WebRequest -Uri $url -OutFile $destination
  Write-Host "ready to extract"
  Write-Host "extracting files...."
  Expand-Archive -Path $destination -DestinationPath $unzip_destination
  Write-Verbose "Apache Maven Installed Successfully"

  #Setting Environment variables
  [Environment]::SetEnvironmentVariable("MAVEN_HOME",$unzipped,"machine")
  [Environment]::SetEnvironmentVariable("Path",$env:Path + ";$unzipped\bin","Machine")
}

$path = "C:\Users\user\OneDrive\Documents\Tomcat dependencies\dependencies.properties"
$output = Get-Content $path | ConvertFrom-StringData

#variables
$url = $output.url
$destination = $output.destination
$unzip_destination = $output.unzip_destination
$mvn_logs_install = $output.mvn_logs_install
$unzipped = $output.unzipped

$VerbosePreference = "continue"

installmaven $url $destination $unzip_destination

Stop-Transcript
