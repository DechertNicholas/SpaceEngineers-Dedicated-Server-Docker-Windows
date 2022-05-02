$ErrorActionPreference = "Stop"

Write-Output "Installing Visual C++ 2013 redistributable"
Start-Process -FilePath "C:\GameData\Installers\vc_redist\2013\vcredist_x64.exe" -ArgumentList "/install","/quiet","/norestart" -Wait -NoNewWindow

Write-Output "Installing Visual C++ 2015+ redistributable"
Start-Process -FilePath "C:\GameData\Installers\vc_redist\2015+\VC_redist.x64.exe" -ArgumentList "/install","/quiet","/norestart" -Wait -NoNewWindow

Write-Output "Installing .NET 4.8 Runtime"
Start-Process -FilePath "C:\GameData\Installers\DotNet4.8\ndp48-web.exe" -ArgumentList "/serialdownload","/norestart","/passive" -Wait -NoNewWindow

if ($null -ne $Error[0]) {
    Write-Output $Error[0]
    return 1
}