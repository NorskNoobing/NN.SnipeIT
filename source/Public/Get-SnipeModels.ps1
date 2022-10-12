function Get-SnipeModels {
    [CmdletBinding(DefaultParameterSetName="List models")]
    param (
        [Parameter(Position=0,ParameterSetName="List models")][string]$search,
        [Parameter(ParameterSetName="List models")][int]$limit,
        [Parameter(ParameterSetName="List models")][int]$offset,
        [Parameter(ParameterSetName="List models")][string]$sort,
        [Parameter(ParameterSetName="List models")][ValidateSet("asc","desc")][int]$order,
        [Parameter(Mandatory,ParameterSetName="Get model by id")][int]$id
    )

    $uri = "$(Get-SnipeEndpoint)/models"

    switch ($PsCmdlet.ParameterSetName) {
        "List models" {
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
        "Get model by id" {
            $uri = "$uri/$id"
        }
    }

    Invoke-SnipeMethod -Method "GET" -Uri $uri
}