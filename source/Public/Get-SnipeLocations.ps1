function Get-SnipeLocations {
    <#
    .SYNOPSIS
        Gets locations from Snipe-IT
    .LINK
        List locations:
        https://snipe-it.readme.io/reference/locations
    .LINK
        Get location by id:
        https://snipe-it.readme.io/reference/locations-1
    .EXAMPLE
        Get-SnipeLocation
        Returns all locations from Snipe-IT.
    .EXAMPLE
        Get-SnipeLocation -name Home
        Returns location based on name.
    .EXAMPLE
        Get-SnipeLocation -search VGS
        Returns locations that have a name that matches the string "VGS".
        Uses wildcards.
    .EXAMPLE
        Get-SnipeLocation -id 1
        Returns location based on the given id.
    #>
    [CmdletBinding(DefaultParameterSetName="List locations")]
    param (
        [Parameter(Position=0,ParameterSetName="List locations")][string]$name,
        [Parameter(ParameterSetName="List locations")][int]$limit,
        [Parameter(ParameterSetName="List locations")][int]$offset,
        [Parameter(ParameterSetName="List locations")][string]$search,
        [Parameter(ParameterSetName="List locations")][string]$sort,
        [Parameter(ParameterSetName="List locations")][ValidateSet("asc","desc")][string]$order,
        [Parameter(ParameterSetName="List locations")][string]$address,
        [Parameter(ParameterSetName="List locations")][string]$address2,
        [Parameter(ParameterSetName="List locations")][string]$city,
        [Parameter(ParameterSetName="List locations")][string]$zip,
        [Parameter(ParameterSetName="List locations")][string]$country,
        [Parameter(Mandatory,ParameterSetName="Get location by id")][int]$id
    )

    $uri = "$(Get-SnipeEndpoint)/locations"

    switch ($PsCmdlet.ParameterSetName) {
        "List locations" {
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
        "Get location by id" {
            $uri = "$uri/$id"
        }
    }

    Invoke-SnipeMethod -Method "GET" -Uri $uri
}