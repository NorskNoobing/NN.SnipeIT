function Get-SnipeCategories {
    [CmdletBinding(DefaultParameterSetName="List categories")]
    param (
        [Parameter(Position=0,ParameterSetName="List categories")][string]$name,
        [Parameter(ParameterSetName="List categories")][int]$limit,
        [Parameter(ParameterSetName="List categories")][int]$offset,
        [Parameter(ParameterSetName="List categories")][string]$search,
        [Parameter(ParameterSetName="List categories")][string]$sort,
        [Parameter(ParameterSetName="List categories")][ValidateSet("asc","desc")][string]$order,
        [Parameter(ParameterSetName="List categories")][int]$category_id,
        [Parameter(ParameterSetName="List categories")][string]$category_type,
        [Parameter(ParameterSetName="List categories")][ValidateSet("true","false")][string]$use_default_eula,
        [Parameter(ParameterSetName="List categories")][ValidateSet("true","false")][string]$require_acceptance,
        [Parameter(ParameterSetName="List categories")][ValidateSet("true","false")][string]$checkin_email,
        [Parameter(Mandatory,ParameterSetName="Get category by id")][int]$id
    )

    $uri = "$(Get-SnipeEndpoint)/categories"

    switch ($PsCmdlet.ParameterSetName) {
        "List categories" {
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
        "Get category by id" {
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
        "List categories" {
            $result.rows
        }
        "Get category by id" {
            $result
        }
    }
}