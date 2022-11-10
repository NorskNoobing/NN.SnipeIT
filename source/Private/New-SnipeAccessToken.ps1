function New-SnipeAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Snipe-IT\snipeitAccessToken.xml"
    )

    $apiKey = Read-Host "Enter Snipe-IT API key" -AsSecureString

    #Create parent folders of the access token file
    $accessTokenDir = $accessTokenPath.Substring(0, $accessTokenPath.lastIndexOf('\'))
    if (!(Test-Path $accessTokenDir)) {
        $null = New-Item -ItemType Directory $accessTokenDir
    }

    #Create access token file
    $apiKey | Export-Clixml $accessTokenPath
}