function New-SnipeEndpoint {
    param (
        [string]$endpointPath = "$env:USERPROFILE\.creds\Snipe-IT\snipeitEndpoint.xml"
    )

    $snipeUrl = Read-Host "Enter Snipe-IT url"
    $endpoint = "$snipeUrl/api/v1"

    #Create parent folders of the access token file 
    $endpointDir = $endpointPath.Substring(0, $endpointPath.lastIndexOf('\'))
    if (!(Test-Path $endpointDir)) {
        New-Item -ItemType Directory $endpointDir | Out-Null
    }

    #Create access token file
    $endpoint | Export-Clixml $endpointPath
}