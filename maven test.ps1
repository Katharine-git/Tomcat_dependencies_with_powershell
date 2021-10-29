# download (if internet connectivity is available)

function downloadmaven($url,$destination){
  # Installing Maven
  Write-Host $url    
  Write-Host "downloading started"
  Invoke-WebRequest -Uri $url -OutFile $destination

installmaven $destination $unzip_destination

}

#function to extract and install maven
function installmaven($destination,$unzip_destination){

  Write-Host "ready to extract"
  Write-Host "extracting files...."

  #unzips the zip file
  Expand-Archive -Path $destination -DestinationPath $unzip_destination

  #Setting Environment variables
  [Environment]::SetEnvironmentVariable("MAVEN_HOME",$unzipped,"machine")
  [Environment]::SetEnvironmentVariable("Path",$env:Path + ";$unzipped\bin","Machine")
  
}

$path = "C:\Users\user\OneDrive\Documents\Tomcat_dependencies\dependencies.properties"
$output = Get-Content $path | ConvertFrom-StringData

#variables
$url = $output.url
$destination = $output.destination
$unzip_destination = $output.unzip_destination
#$mvn_logs_install = $output.mvn_logs_install
$unzipped = $output.unzipped
$servername = $output.servername

$VerbosePreference = "continue"

# call both functions...

if ((Test-Connection -ComputerName $servername -Quiet) -eq "True")
{
  Write-Verbose "Server have Internet access"
  downloadmaven $url $destination
}
else
{
  installmaven $destination $unzip_destination
}