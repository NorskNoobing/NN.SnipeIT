function Get-SnipeConsumables {
    [CmdletBinding(DefaultParameterSetName="List consumables")]
    param (
        [Parameter(Position=0,ParameterSetName="List consumables")][string]$name,
        [Parameter(ParameterSetName="List consumables")][int]$limit,
        [Parameter(ParameterSetName="List consumables")][int]$offset,
        [Parameter(ParameterSetName="List consumables")][string]$search,
        [Parameter(ParameterSetName="List consumables")][string]$order_number,
        [Parameter(ParameterSetName="List consumables")][ValidateSet(
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
        [Parameter(ParameterSetName="List consumables")][ValidateSet("asc","desc")][string]$order,
        [Parameter(ParameterSetName="List consumables")][ValidateSet("true","false")][string]$expand,
        [Parameter(ParameterSetName="List consumables")][int]$category_id,
        [Parameter(ParameterSetName="List consumables")][int]$company_id,
        [Parameter(ParameterSetName="List consumables")][int]$manufacturer_id,
        [Parameter(Mandatory,ParameterSetName="Get consumable by id")][int]$id
    )
    
    $uri = "$(Get-SnipeEndpoint)/consumables"

    switch ($PsCmdlet.ParameterSetName) {
        "List consumables" {
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
        "Get consumable by id" {
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
        "List consumables" {
            $result.rows
        }
        "Get consumable by id" {
            $result
        }
    }
}