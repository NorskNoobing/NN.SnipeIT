function Get-SnipeCompanies {
    [CmdletBinding(DefaultParameterSetName="List companies")]
    param (
        [Parameter(Position=0,ParameterSetName="List companies")][string]$name,
        [Parameter(Mandatory,ParameterSetName="Get company by id")][int]$id
    )

    $uri = "$(Get-SnipeEndpoint)/companies"

    switch ($PsCmdlet.ParameterSetName) {
        "List companies" {
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
        "Get company by id" {
            $uri = "$uri/$id"
        }
    }

    Invoke-SnipeMethod -Method "GET" -Uri $uri
}