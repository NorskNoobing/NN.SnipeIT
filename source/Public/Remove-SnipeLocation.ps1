function Remove-SnipeLocation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$id
    )

    process {
        $Splat = @{
            "Uri" = "$(Get-SnipeEndpoint)/locations/$id"
            "Method" = "DELETE"
            "Headers" = @{
                "Accept" = "application/json"
                "Content-Type" = "application/json"
                "Authorization" = "Bearer $(Get-SnipeAccessToken)"
            }
        }
        Invoke-RestMethod @Splat
    }
}