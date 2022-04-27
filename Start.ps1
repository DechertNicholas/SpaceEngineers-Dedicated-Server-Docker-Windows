# Quit on any errors
$ErrorActionPreference = "Stop"

Write-Output "----- Starting Container ------"
# while ($true) {
#     Write-Output "Sitting pretty"
#     Start-Sleep 15
# }
Write-Output "- Running in $(Get-Location)"
Write-Output "----- Checking for Steam ------"
if (-not (Test-Path ".\Steam\steamcmd.exe")) {
    # Steam not installed, see if it should be automatically installed
    # Data will not persist if you have not mounted the steam folder!
    if($env:INSTALLSTEAM.ToUpper() -eq "TRUE") {
        Write-Output "Steam not installed, `$env:INSTALLSTEAM is $env:INSTALLSTEAM - Installing"
        Write-Output "- Downloading..."
        Invoke-WebRequest "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip" -UseBasicParsing -OutFile .\Steam\steamcmd.zip
        Write-Output "- Extracting zip..."
        Expand-Archive .\Steam\steamcmd.zip -DestinationPath .\Steam
    } else {
        # Generate a full filename for a nice error
        $expectedPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(".\Steam\steamcmd.exe")
        throw "Unable to find steamcmd.exe at $expectedPath"
    }
    
}

Write-Output "----- Updating Server ---------"
C:\GameData\Steam\steamcmd.exe +login anonymous +app_update 298740 +quit

Write-Output "----- Setting Configs ---------"
$configFile = "C:\GameData\Instances\$env:INSTANCENAME\SpaceEngineers-Dedicated.cfg"

$config = [Xml] (Get-Content $configFile)

# The "LoadWorld" XML item will be set to the wrong place most likely, so fix it
$config.MyConfigDedicated.LoadWorld = $config.MyConfigDedicated.LoadWorld -replace ".*($env:INSTANCENAME\\Saves\\.*\\Sandbox.sbc)",'C:\GameData\Instances\$1'

$config.Save("$configFile")

Write-Output "----- Starting Server ---------"
& "C:\GameData\Steam\steamapps\common\SpaceEngineersDedicatedServer\DedicatedServer64\SpaceEngineersDedicated.exe" -console -ignorelastsession -path "C:\GameData\Instances\$env:INSTANCENAME"
# The exe starts a new process, then returns to the console. We need to wait around while that process runs
$Running = $true
while ($Running) {
    # Check if running every second, break out and leave if not
    Start-Sleep 1
    if ($null -eq (Get-Process "*SpaceEngineers*")) {
        $Running = $false
    }
}