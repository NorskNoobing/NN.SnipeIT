function Get-SnipeAsset {
    [CmdletBinding(DefaultParameterSetName="List assets")]
    param (
        [Parameter(ParameterSetName="List assets")][int]$limit,
        [Parameter(ParameterSetName="List assets")][int]$offset,
        [Parameter(Position=0,ParameterSetName="List assets")][string]$search,
        [Parameter(ParameterSetName="List assets")][string]$order_number,
        [Parameter(ParameterSetName="List assets")][ValidateSet(
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
        [Parameter(ParameterSetName="List assets")][ValidateSet("asc","desc")][string]$order,
        [Parameter(ParameterSetName="List assets")][int]$model_id,
        [Parameter(ParameterSetName="List assets")][int]$category_id,
        [Parameter(ParameterSetName="List assets")][int]$manufacturer_id,
        [Parameter(ParameterSetName="List assets")][int]$company_id,
        [Parameter(ParameterSetName="List assets")][int]$location_id,
        [Parameter(ParameterSetName="List assets")][ValidateSet(
            "RTD",
            "Deployed",
            "Undeployable",
            "Deleted",
            "Archived",
            "Requestable"
            )][string]$status,
        [Parameter(ParameterSetName="List assets")][int]$status_id,
        [Parameter(Mandatory,ParameterSetName="Get asset by id")][int]$id,
        [Parameter(Mandatory,ParameterSetName="Get asset by asset_tag")][string]$asset_tag,
        [Parameter(Mandatory,ParameterSetName="Get asset by serial")][string]$serial,
        [Parameter(ParameterSetName="List assets by audit_due")][switch]$audit_due,
        [Parameter(ParameterSetName="List assets by audit_overdue")][switch]$audit_overdue
    )

    $uri = "$(Get-SnipeEndpoint)/hardware"

    switch ($PsCmdlet.ParameterSetName) {
        "List assets" {
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
        "Get asset by id" {
            $uri = "$uri/$id"
        }
        "Get asset by asset_tag" {
            $uri = "$uri/bytag/$asset_tag"
        }
        "Get asset by serial" {
            $uri = "$uri/byserial/$serial"
        }
        "List assets by audit_due" {
            $uri = "$uri/audit/due"
        }
        "List assets by audit_overdue" {
            $uri = "$uri/audit/overdue"
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
        {($_ -eq "Get asset by id") -or ($_ -eq "Get asset by asset_tag")} {
            $result
        }
        default {
            $result.rows
        }
    }
}