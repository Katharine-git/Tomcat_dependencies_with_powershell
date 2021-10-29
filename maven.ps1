
#downloading
function downloadmaven ($url,$destination) {

  Invoke-WebRequest -Uri $url -OutFile $destination
  if (Test-Path $destination)
  {
    Write-Verbose "ready to extract"
    Write-Verbose "extracting files...."
  }


  #---------------------------------------------------------------------

  installmaven $destination,$unzip_destination
}
#installing
function installmaven ($destination,$unzip_destination) {
  Expand-Archive Path $destination -DestinationPath $unzip_destination -Force
  if (Test-Path $unzip_destination\$mavenversion)
  {
    Write-Verbose "File extracted successfully"
  }
  else
  {
    Write-Verbose "File extraction failed. Please check the path is correct"
  }
  
  #Setting Environment variables
  [Environment]::SetEnvironmentVariable("MAVEN_HOME",$unzipped,"machine")
  [Environment]::SetEnvironmentVariable("Path",$env:Path + ";$unzipped\bin","Machine")

}

#variables
$path = "C:\Users\user\OneDrive\Documents\maven\maven.properties"
$output = Get-Content $path | ConvertFrom-StringData


$url = $output.url
$destination = $output.destination
$unzip_destination = $output.unzip_destination
$mavenversion = $output.mavenversion
$logpath = $output.logpath
$VerbosePreference = "continue"
$servername = $output.servername
Start-Transcript -Path $logpath
uninstallmaven $unzip_destination



if ((Test-Connection -ComputerName $servername -Quiet) -eq "True")
{
  Write-Verbose "Server have Internet access"
  downloadmaven $url,$destination
}
else
{
  installmaven $destination,$unzip_destination
}


Stop-Transcript
