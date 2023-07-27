function Update-SnipeUser {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string]$id,
        [Parameter(Mandatory)][ValidateSet("PATCH","PUT")][string]$method,
        [string]$first_name,
        [string]$last_name,
        [string]$username,
        [string]$password,
        [string]$email,
        [string]$permissions,
        [bool]$activated,
        [string]$phone,
        [string]$jobtitle,
        [int]$manager_id,
        [string]$employee_num,
        [string]$notes,
        [int]$company_id,
        [bool]$two_factor_enrolled,
        [bool]$two_factor_optin,
        [int]$department_id,
        [int]$location_id,
        [bool]$remote,
        [array]$groups,
        [int]$vip,
        [datetime]$start_date,
        [datetime]$end_date
    )

    $ParameterExclusion = @("method","id")
    $Body = $null
    $PSBoundParameters.Keys.ForEach({
        [string]$Key = $_
        $Value = $PSBoundParameters.$key
    
        if ($ParameterExclusion -contains $Key) {
            return
        }

        switch ($Value) {
            {($_ -is [bool]) -and ($_ -eq $true)} {
                $Value = 1
            }
            {($_ -is [bool]) -and ($_ -eq $false)} {
                $Value = 0
            }
            {$_ -is [array]} {
                [string]$Value = $Value -join ","
            }
        }
    
        $Body += @{
            $Key = $Value
        }
    })

    $Splat = @{
        "Uri" = "$(Get-SnipeEndpoint)/users/$id"
        "Method" = $method
        "Headers" = @{
            "Accept" = "application/json"
            "Content-Type" = "application/json"
            "Authorization" = "Bearer $(Get-SnipeAccessToken)"
        }
        "Body" = [System.Text.Encoding]::UTF8.GetBytes(($Body | ConvertTo-Json -Depth 99))
    }
    Invoke-RestMethod @Splat
}