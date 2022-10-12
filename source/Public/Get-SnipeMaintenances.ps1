function Get-SnipeMaintenances {
    [CmdletBinding(DefaultParameterSetName="List maintenances")]
    param (
        [Parameter(ParameterSetName="List maintenances")][int]$limit,
        [Parameter(ParameterSetName="List maintenances")][int]$offset,
        [Parameter(Position=0,ParameterSetName="List maintenances")][string]$search,
        [Parameter(ParameterSetName="List maintenances")][string]$sort,
        [Parameter(ParameterSetName="List maintenances")][string]$order,
        [Parameter(ParameterSetName="List maintenances")][int]$asset_id
    )

    $uri = "$(Get-SnipeEndpoint)/maintenances"

    switch ($PsCmdlet.ParameterSetName) {
        "List maintenances" {
            $PSBoundParameters.Keys.ForEach({
                $key = $_
                $value = $PSBoundParameters.$key

                if (([array]$PSBoundParameters.Keys)[0] -eq $key) {
                    $delimiter = "?"
                } else {
                    $delimiter = "&"
                }

                $uri = "$uri$delimiter$key=$value"
            })
        }
    }

    $splat = @{
        "Uri" = $uri
        "Method" = "GET"
        "Headers" = @{
            "Authorization" = "Bearer $(Get-SnipeAccessToken)"
            "Accept" = "application/json"
            "Content-Type" = "application/json"
        }
    }
    $result = Invoke-RestMethod @splat
    
    switch ($PsCmdlet.ParameterSetName) {
        "List maintenances" {
            $result.rows
        }
    }
}