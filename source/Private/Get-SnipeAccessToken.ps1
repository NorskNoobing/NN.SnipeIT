function Get-SnipeAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Snipe-IT\snipeitAccessToken.xml"
    )

    if (!(Test-Path $accessTokenPath)) {
        New-SnipeAccessToken
    }

    Import-Clixml $accessTokenPath | ConvertFrom-SecureString -AsPlainText
}