function Get-SnipeUsers {
    [CmdletBinding(DefaultParameterSetName="List users")]
    param (
        [Parameter(Position=0,ParameterSetName="List users")][string]$search,
        [Parameter(ParameterSetName="List users")][int]$limit,
        [Parameter(ParameterSetName="List users")][int]$offset,
        [Parameter(ParameterSetName="List users")][string]$sort,
        [Parameter(ParameterSetName="List users")][ValidateSet("asc","desc")][string]$order,
        [Parameter(ParameterSetName="List users")][string]$first_name,
        [Parameter(ParameterSetName="List users")][string]$last_name,
        [Parameter(ParameterSetName="List users")][string]$username,
        [Parameter(ParameterSetName="List users")][string]$email,
        [Parameter(ParameterSetName="List users")][string]$employee_num,
        [Parameter(ParameterSetName="List users")][string]$state,
        [Parameter(ParameterSetName="List users")][string]$zip,
        [Parameter(ParameterSetName="List users")][string]$country,
        [Parameter(ParameterSetName="List users")][int]$group_id,
        [Parameter(ParameterSetName="List users")][int]$department_id,
        [Parameter(ParameterSetName="List users")][int]$company_id,
        [Parameter(ParameterSetName="List users")][int]$location_id,
        [Parameter(ParameterSetName="List users")][ValidateSet("true","false")][string]$deleted,
        [Parameter(ParameterSetName="List users")][ValidateSet("true","false")][string]$all,
        [Parameter(ParameterSetName="List users")][ValidateSet("0","1")][int]$ldap_import,
        [Parameter(ParameterSetName="List users")][int]$asset_count,
        [Parameter(ParameterSetName="List users")][int]$licenses_count,
        [Parameter(ParameterSetName="List users")][int]$accessories_count,
        [Parameter(ParameterSetName="List users")][int]$consumables_count,
        [Parameter(ParameterSetName="List users")][ValidateSet("0","1")][int]$remote,
        [Parameter(Mandatory,ParameterSetName="Get user by id")][int]$id
    )

    $uri = "$(Get-SnipeEndpoint)/users"

    switch ($PsCmdlet.ParameterSetName) {
        "List users" {
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
        "Get user by id" {
            $uri = "$uri/$id"
        }
    }

    Invoke-SnipeMethod -Method "GET" -Uri $uri
}