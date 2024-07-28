function Get-SpotifyCurrentUserSavedAlbums {

    process{
        $header = @{
            authorization = "Bearer " + $SpotifyAccessToken
        }
        $albums = @{ next = "https://api.spotify.com/v1/me/albums?limit=50" }
        & { while($albums.next -and -Not $e){
                $albums = Invoke-RestMethod -Uri $albums.next -Method GET -Headers $header -ContentType "application/json" -ErrorVariable "e"; $albums
            } 
        } | Select-Object -ExpandProperty items | Select-Object -ExpandProperty album -Property * -ExcludeProperty album
    }

}