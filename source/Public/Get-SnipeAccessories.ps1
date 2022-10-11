function Get-SnipeAccessories {
    [CmdletBinding(DefaultParameterSetName="List accessories")]
    param (
        [Parameter(Position=0,ParameterSetName="List accessories")][string]$search,
        [Parameter(ParameterSetName="List accessories")][int]$limit,
        [Parameter(ParameterSetName="List accessories")][int]$offset,
        [Parameter(ParameterSetName="List accessories")][string]$order_number,
        [Parameter(ParameterSetName="List accessories")][ValidateSet(
            "id",
            "name",
            "asset_tag",
            "serial",
            "model",
            "model_number",
            "last_checkout",
            "category",
            "manufacturer",
            "notes",
            "expected_checkin",
            "order_number",
            "companyName",
            "location",
            "image",
            "status_label",
            "assigned_to",
            "created_at",
            "purchase_date",
            "purchase_cost"
            )][string]$sort,
        [Parameter(ParameterSetName="List accessories")][ValidateSet("asc","desc")][string]$order,
        [Parameter(ParameterSetName="List accessories")][ValidateSet("true","false")][string]$expand,
        [Parameter(Mandatory,ParameterSetName="Get accessory by id")][int]$id,
        [Parameter(ParameterSetName="Get accessory by id")][switch]$listCheckedOut

    )

    $uri = "$(Get-SnipeEndpoint)/accessories"

    switch ($PsCmdlet.ParameterSetName) {
        "List accessories" {
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
        "Get accessory by id" {
            $uri = "$uri/$id"
            if ($listCheckedOut) {
                $uri = "$uri/checkedout"
            }
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
        {($_ -eq "Get accessory by id") -and !$listCheckedOut} {
            $result
        }
        default {
            $result.rows
        }
    }
}