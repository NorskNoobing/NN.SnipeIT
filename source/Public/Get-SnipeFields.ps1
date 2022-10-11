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
        "List fields" {
            $result.rows
        }
        "Get field by id" {
            $result
        }
    }
}