function Get-SnipeFieldsets {
    [CmdletBinding(DefaultParameterSetName="List fieldsets")]
    param (
        [Parameter(Mandatory,ParameterSetName="Get fieldset by id")][int]$id,
        [Parameter(ParameterSetName="List fieldsets")][switch]$listfieldsets
    )

    $uri = "$(Get-SnipeEndpoint)/fieldsets"

    switch ($PsCmdlet.ParameterSetName) {
        "Get fieldset by id" {
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
        "List fieldsets" {
            $result.rows
        }
        "Get fieldset by id" {
            $result
        }
    }
}