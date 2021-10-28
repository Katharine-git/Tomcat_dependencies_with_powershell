#---------------------Installing Java jdk 8-------------------------------------
function InstallJava ($javaVersion,$jdkVersion,$url,$fileName,$jdkPath,$jrePath) {

  #starting Transcripts for logs..
  Start-Transcript -Path $java_logs_install

  Write-Host "Installing $javaVersion..."

  #download
  Write-Verbose "Downloading installer"
  $exePath = "$env:USERPROFILE\$fileName"
  $logPath = "$env:USERPROFILE\$fileName-install.log"
  [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
  $client = New-Object Net.WebClient
  $client.Headers.Add('Cookie','gpw_e24=http://www.oracle.com; oraclelicense=accept-securebackup-cookie')
  $client.DownloadFile($url,$exePath)

  #Silent install Java
  $arguments = "/c start /wait $exePath /s ADDLOCAL=`"ToolsFeature,PublicjreFeature`" INSTALLDIR=`"$jdkPath`" /INSTALLDIRPUBJRE=`"$jrePath`""
  Start-Process cmd.exe -WindowStyle Hidden -ArgumentList $arguments

  #installation paths
  Write-Host "Installing JDK to $jdkPath"
  Write-Host "Installing JRE to $jrePath"

  #waiting time for complete installation
  Start-Sleep -s 20

  Write-Verbose "$javaVersion installed"
}

$path = "C:\Users\user\OneDrive\Documents\JAVA\dependencies.properties"
$output = Get-Content $path | ConvertFrom-StringData

#variables
$javaVersion = $output.javaVersion
$jdkVersion = $output.jdkVersion
$fileName = $output.fileName
$jdk = $output.jdk
$jre = $output.jre
$java_logs_install = $output.java_logs_install

$VerbosePreference = "continue"
InstallJava $javaVersion $jdkVersion "https://storage.googleapis.com/appveyor-download-cache/jdk/$fileName" $fileName "$env:ProgramFiles\Java\$jdk" "$env:ProgramFiles\Java\$jre"

# Set Java home
[Environment]::SetEnvironmentVariable("JAVA_HOME","C:\Progra~1\Java\$jdk","machine")
$env:JAVA_HOME = "C:\Progra~1\Java\$jdk"

Stop-Transcript
