function Get-SnipeFields {
    [CmdletBinding(DefaultParameterSetName="List fields")]
    param (
        [Parameter(Mandatory,ParameterSetName="Get field by id")][int]$id,
        [Parameter(ParameterSetName="List fields")][switch]$listField
    )

    $uri = "$(Get-SnipeEndpoint)/fields"

    switch ($PsCmdlet.ParameterSetName) {
        "Get field by id" {
            $uri = "$uri/$id"
        }
    }

    Invoke-SnipeMethod -Method "GET" -Uri $uri
}