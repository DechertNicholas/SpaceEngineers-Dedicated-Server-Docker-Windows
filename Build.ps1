[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $LTSC = "2022"
)

$Tag = "dechertnicholas/space-engineers-ds-windows:ltsc$LTSC"
$LTSC = "mcr.microsoft.com/windows/servercore:ltsc$LTSC"

if (-not $env:GITHUB_ACTIONS) {
    $Tag += "-local" # Differentiate local builds
    docker build --isolation hyperv --build-arg "LTSC=$LTSC" . -t $Tag
} else {
    docker build --build-arg "LTSC=$LTSC" . -t $Tag
}