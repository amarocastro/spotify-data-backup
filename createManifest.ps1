$year = (Get-Date).Year
$moduleName = 'SpotifyBackup'
$templateString = 'Spotify Backup Module'
$version = '1.2'

$moduleManifestParameters = @{
    Path = "$PWD\$moduleName.psd1"
    Author = $templateString
    ModuleVersion = $version
    Description = $templateString
    RootModule = "$moduleName.psm1"
    FunctionsToExport = @("Get-SpotifyAccessToken","Get-SpotifyAuthorization","Get-CurrentUserFollowedArtists","Get-SpotifyCurrentuserPlaylists","Get-SpotifyCurrentuserSavedAlbums","Get-SpotifyCurrentUserSavedTracks","Get-SpotifyPlaylistTracks","Refresh-SpotifyAccessToken")
}

New-ModuleManifest @moduleManifestParameters