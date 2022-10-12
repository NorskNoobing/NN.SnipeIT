function Get-SnipeManufacturers {
    [CmdletBinding(DefaultParameterSetName="List manufacturers")]
    param (
        [Parameter(Position=0,ParameterSetName="List manufacturers")][string]$name,
        [Parameter(ParameterSetName="List manufacturers")][string]$url,
        [Parameter(ParameterSetName="List manufacturers")][string]$support_url,
        [Parameter(ParameterSetName="List manufacturers")][string]$support_phone,
        [Parameter(ParameterSetName="List manufacturers")][string]$support_email,
        [Parameter(Mandatory,ParameterSetName="Get manufacturer by id")][int]$id
    )

    $uri = "$(Get-SnipeEndpoint)/manufacturers"

    switch ($PsCmdlet.ParameterSetName) {
        "List manufacturers" {
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
        "Get manufacturer by id" {
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
        "List manufacturers" {
            $result.rows
        }
        "Get manufacturer by id" {
            $result
        }
    }
}