ARG LTSC
FROM $LTSC 
# mcr.microsoft.com/windows/servercore:ltsc2022

COPY ".\\Installers" "C:\\GameData\\Installers"

RUN "C:\GameData\Installers\vc_redist\2013\vcredist_x64.exe /install /quiet /norestart"
RUN "C:\GameData\Installers\vc_redist\2015+\VC_redist.x64.exe /install /quiet /norestart"
RUN "C:\GameData\Installers\DotNet4.8\ndp48-web.exe /serialdownload /norestart /passive"

SHELL [ "PowerShell.exe", "-Command" ]
WORKDIR "C:\GameData"

COPY ".\\Start.ps1" "C:\\GameData\\"

ENTRYPOINT C:\GameData\Start.ps1