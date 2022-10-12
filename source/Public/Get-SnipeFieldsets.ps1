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

    Invoke-SnipeMethod -Method "GET" -Uri $uri
}