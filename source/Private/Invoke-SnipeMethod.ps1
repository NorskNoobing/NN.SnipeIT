function Invoke-SnipeMethod {
    param (
        [Parameter(Mandatory)][string]$Uri,
        [Parameter(Mandatory)][ValidateSet("GET","POST","PUT","PATCH","DELETE")][string]$Method
    )
    
    $splat = @{
        "Uri" = $uri
        "Method" = $Method
        "Headers" = @{
            "Authorization" = "Bearer $(Get-SnipeAccessToken)"
            "Accept" = "application/json"
            "Content-Type" = "application/json"
        }
    }
    $result = Invoke-RestMethod @splat

    if ($result.PSObject.Properties.name -contains "rows") {
        $result.rows
    } else {
        $result
    }
}