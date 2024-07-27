
function Get-SpotifyCurrentUserPlaylists {
    $cred_bytes = [System.Text.Encoding]::UTF8.GetBytes(($SpotifyClientId+":"+$SpotifyClientSecret))
    $bearer = [Convert]::ToBase64String($cred_bytes)

    $current_playlists = Invoke-RestMethod -Uri "https://api.spotify.com/v1/me/playlists" -Method GET -Headers @{Authorization="Bearer "+ $SpotifyAccessToken}
}