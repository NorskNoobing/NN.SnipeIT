function Get-SnipeEndpoint {
    param (
        [string]$endpointPath = "$env:USERPROFILE\.creds\Snipe-IT\snipeitEndpoint.xml"
    )

    if (!(Test-Path $endpointPath)) {
        New-SnipeEndpoint
    }

    Import-Clixml $endpointPath
}