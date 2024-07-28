# Import-Module .\Private\.init-spotify-pws-module.ps1 -Force
# Import-Module ./Public/Get-SpotifyCurrentUserSavedTracks.ps1 -Force
# Import-Module ./Public/Get-SpotifyCurrentUserSavedAlbums.ps1 -Force
# Import-Module ./Public/Get-SpotifyCurrentUserFollowedArtists.ps1 -Force
# Import-Module ./Public/Get-SpotifyCurrentUserPlaylists.ps1 -Force
# Import-Module ./Public/Get-SpotifyPlaylistTracks.ps1 -Force

# Init-Module
Import-Module .\Spotify-Reader-Module
$playlists = Get-SpotifyCurrentUserPlaylists


