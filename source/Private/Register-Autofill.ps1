$Splat = @{
    "CommandName" = "Get-SnipeLocations"
    "ParameterName" = "name"
    "ScriptBlock" = {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

        $AllLocationNames = (Get-SnipeLocations).name | Sort-Object
        $AllLocationNames.Where({
            $_ -like "$wordToComplete*"
        }).ForEach({
            "`"$_`""
        })
    }
}
Register-ArgumentCompleter @Splat