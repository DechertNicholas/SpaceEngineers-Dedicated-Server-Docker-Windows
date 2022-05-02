[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $LTSC = "2022"
)

$Tag = "dechertnicholas/space-engineers-ds-windows:ltsc$LTSC"
if (-not $env:GITHUB_ACTIONS) {
    $Tag += "-local" # Differentiate local builds
}
$LTSC = "mcr.microsoft.com/windows/servercore:ltsc$LTSC"

docker build --isolation hyperv --build-arg "LTSC=$LTSC" . -t $Tag