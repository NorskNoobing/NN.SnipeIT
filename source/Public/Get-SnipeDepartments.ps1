function Get-SnipeDepartments {
    [CmdletBinding(DefaultParameterSetName="List departments")]
    param (
        [Parameter(Position=0,ParameterSetName="List departments")][string]$name,
        [Parameter(ParameterSetName="List departments")][int]$company_id,
        [Parameter(ParameterSetName="List departments")][int]$manager_id,
        [Parameter(ParameterSetName="List departments")][int]$location_id,
        [Parameter(Mandatory,ParameterSetName="Get department by id")][int]$id
    )

    $uri = "$(Get-SnipeEndpoint)/departments"

    switch ($PsCmdlet.ParameterSetName) {
        "List departments" {
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
        "Get department by id" {
            $uri = "$uri/$id"
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
        "List departments" {
            $result.rows
        }
        "Get department by id" {
            $result
        }
    }
}