Import-Module .\Private\.init-spotify-pws-module.ps1 -Force
Import-Module ./Public/Get-SpotifyUserSavedTracks.ps1 -Force
Import-Module ./Public/Get-SpotifyCurrentUserPlaylists.ps1 -Force

# $global:SpotifyBasicBearer             = ""
# $global:SpotifyClientId                = "66dd5a4ae82742c98c3d7f883b86070c"
# $global:SpotifyClientSecret            = "425de384fb6d4c229da1c853e8d5d920"
# $global:SpotifyAccessTokenDateExpires  = (Get-Date)


Init-Module
$playlists = Get-SpotifyCurrentUserPlaylists


# Get-SpotifyAccessToken
# Get-SpotifyUserSavedTracks      