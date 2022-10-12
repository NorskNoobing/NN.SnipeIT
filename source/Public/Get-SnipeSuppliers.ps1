function Get-SnipeSuppliers {
    [CmdletBinding(DefaultParameterSetName="List suppliers")]
    param (
        [Parameter(Position=0,ParameterSetName="List suppliers")][string]$name,
        [Parameter(ParameterSetName="List suppliers")][string]$address,
        [Parameter(ParameterSetName="List suppliers")][string]$address2,
        [Parameter(ParameterSetName="List suppliers")][string]$city,
        [Parameter(ParameterSetName="List suppliers")][string]$zip,
        [Parameter(ParameterSetName="List suppliers")][string]$country,
        [Parameter(ParameterSetName="List suppliers")][string]$fax,
        [Parameter(ParameterSetName="List suppliers")][string]$email,
        [Parameter(ParameterSetName="List suppliers")][string]$url,
        [Parameter(ParameterSetName="List suppliers")][string]$notes,
        [Parameter(Mandatory,ParameterSetName="Get supplier by id")][int]$id
    )

    $uri = "$(Get-SnipeEndpoint)/suppliers"

    switch ($PsCmdlet.ParameterSetName) {
        "List suppliers" {
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
        "Get supplier by id" {
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
        "List suppliers" {
            $result.rows
        }
        "Get supplier by id" {
            $result
        }
    }
}