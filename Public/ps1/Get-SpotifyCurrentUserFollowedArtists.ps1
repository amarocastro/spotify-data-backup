function Get-SpotifyCurrentUserFollowedArtists {

    process{
        $header = @{
            authorization = "Bearer " + $SpotifyAccessToken
        }
        $artists = @{ next = "https://api.spotify.com/v1/me/following?type=artist&limit=50" }
        & { while($artists.next -and -Not $e){
                $artists = Invoke-RestMethod -Uri $artists.next -Method GET -Headers $header -ContentType "application/json" -ErrorVariable "e" | Select-Object -ExpandProperty artists; $artists
            } 
        } | Select-Object -ExpandProperty items
    }
}