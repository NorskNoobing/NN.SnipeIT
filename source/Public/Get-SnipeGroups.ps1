function Get-SnipeGroups {
    [CmdletBinding(DefaultParameterSetName="List groups")]
    param (
        [Parameter(Position=0,ParameterSetName="List groups")][string]$name,
        [Parameter(Mandatory,ParameterSetName="Get group by id")][int]$id
    )

    $uri = "$(Get-SnipeEndpoint)/groups"

    switch ($PsCmdlet.ParameterSetName) {
        "List groups" {
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
        "Get group by id" {
            $uri = "$uri/$id"
        }
    }

    Invoke-SnipeMethod -Method "GET" -Uri $uri
}