$year = (Get-Date).Year
$moduleName = 'SpotifyBackup'
$templateString = 'Spotify Backup Module'
$version = '1.1'

$moduleManifestParameters = @{
    Path = "$PWD\$moduleName.psd1"
    Author = $templateString
    ModuleVersion = $version
    Description = $templateString
    RootModule = "$moduleName.psm1"
}

New-ModuleManifest @moduleManifestParameters