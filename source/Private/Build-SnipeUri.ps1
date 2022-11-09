function Build-SnipeUri {
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