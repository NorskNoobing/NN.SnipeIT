function New-SnipeLocation {
    param (
        [Parameter(Mandatory)][string]$name,
        [string]$address,
        [string]$address2,
        [string]$state,
        [string]$country,
        [string]$city,
        [string]$zip,
        [string]$ldap_ou,
        [int]$parent_id,
        [string]$currency,
        [int]$manager_id
    )

    $Body = $null
    $PSBoundParameters.Keys.ForEach({
        [string]$Key = $_
        $Value = $PSBoundParameters.$key
    
        if ($ParameterExclusion -contains $Key) {
            return
        }
    
        $Body += @{
            $Key = $Value
        }
    })

    $Splat = @{
        "Uri" = "$(Get-SnipeEndpoint)/locations"
        "Method" = "POST"
        "Headers" = @{
            "Accept" = "application/json"
            "Content-Type" = "application/json"
            "Authorization" = "Bearer $(Get-SnipeAccessToken)"
        }
        "Body" = [System.Text.Encoding]::UTF8.GetBytes(($Body | ConvertTo-Json -Depth 99))
    }
    Invoke-RestMethod @Splat
}