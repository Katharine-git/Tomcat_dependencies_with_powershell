#---------------------Uninstall Java----------------------------------------------
function GetUninstallString ($productName) {

  #PowerShell script to uninstall Java SE (JRE) version on computer
  $x64items = @(Get-ChildItem "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")
  ($x64items + @(Get-ChildItem "HKLM:SOFTWARE\wow6432node\Microsoft\Windows\CurrentVersion\Uninstall") `
       | ForEach-Object { Get-ItemProperty Microsoft.PowerShell.Core\Registry::$_ } `
       | Where-Object { $_.DisplayName -and $_.DisplayName -eq $productName } `
       | Select-Object UninstallString).UninstallString
}
function UninstallJava ($name) {
  $java8 = (GetUninstallString 'Java SE Development Kit 8 Update 221')
  $uninstallCommand = (GetUninstallString $name)
  if ($uninstallCommand) {
    Write-Host "Uninstalling $name"

    $uninstallCommand = $uninstallCommand.Replace('MsiExec.exe /I{','/x{').Replace('MsiExec.exe /X{','/x{')
    cmd /c start /wait msiexec.exe $uninstallCommand /quiet

    Write-Host "Uninstalled $name"
  }
}

$path = "C:\Users\user\OneDrive\Documents\JAVA\dependencies.properties"
$output = Get-Content $path | ConvertFrom-StringData

#starting Transcripts for logs..
Start-Transcript -Path $java_logs_uninstall

#variables
$java_logs_uninstall = $output.java_logs_uninstall

#Calling Java uninstall functions
UninstallJava 'Java SE Development Kit 8 Update 221'
UninstallJava 'Java SE Development Kit 8 Update 221 (64-bit)'
UninstallJava 'Java 8 Update 221'
UninstallJava 'Java 8 Update 221 (64-bit)'

#End of transcription
Stop-Transcript
