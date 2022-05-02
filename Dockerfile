ARG LTSC
FROM $LTSC 
# mcr.microsoft.com/windows/servercore:ltsc2022

SHELL [ "PowerShell.exe", "-Command" ]
COPY ".\\Installers" "C:\\GameData\\Installers"
RUN "C:\GameData\Installers\Install-Prerequisites.ps1"

WORKDIR "C:\GameData"
COPY ".\\Start.ps1" "C:\\GameData\\"

ENTRYPOINT C:\GameData\Start.ps1