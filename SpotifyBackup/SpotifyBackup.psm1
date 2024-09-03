Get-ChildItem -Path "$PSScriptRoot\Public\ps1\" -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}

# $directorySeparator = [System.IO.Path]::DirectorySeparatorChar
# $moduleName = $PSScriptRoot.Split($directorySeparator)[-1]
# $moduleManifest = $PSScriptRoot + $directorySeparator + $moduleName + '.psd1'
# $publicFunctionsPath = $PSScriptRoot + $directorySeparator + 'Public' + $directorySeparator + 'ps1'
# $currentManifest = Test-ModuleManifest $moduleManifest

# $aliases = @()
# $publicFunctions = Get-ChildItem -Path $publicFunctionsPath | Where-Object {$_.Extension -eq '.ps1'}
# $publicFunctions | ForEach-Object { . $_.FullName }

# $publicFunctions | ForEach-Object { 
    
#     $alias = Get-Alias -Definition $_.BaseName -ErrorAction SilentlyContinue
#     if ($alias) {
#         $aliases += $alias
#         Export-ModuleMember -Function $_.BaseName -Alias $alias
#     }
#     else {
#         Export-ModuleMember -Function $_.BaseName
#     }

# }
