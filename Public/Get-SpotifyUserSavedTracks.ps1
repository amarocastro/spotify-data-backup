function Get-SpotifyUserSavedTracks {
    Write-Host $SpotifyAccessToken
     $result = Invoke-RestMethod -Uri "https://api.spotify.com/v1/me/tracks" -Method GET -Header @{ Autorizathion="Bearer $SpotifyAccessToken"; "contenttype" = "application/json" }

    # return $result
    
}