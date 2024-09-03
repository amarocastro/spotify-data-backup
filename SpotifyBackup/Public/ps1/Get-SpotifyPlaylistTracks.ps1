function Get-SpotifyPlaylistTracks{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=0)]
        [Alias("AccessToken")]
        [string]$access_token,
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=1)]
        [Alias("PlaylistId")]
        [string]$playlist_id
    )

    process{
        $header = @{
            authorization = "Bearer " + $access_token
        }
        $tracks = @{ next = "https://api.spotify.com/v1/playlists/$playlist_id/tracks?limit=50" }
        & { while($tracks.next -and -Not $e){
                $tracks = Invoke-RestMethod -Uri $tracks.next -Method GET -Headers $header -ContentType "application/json" -ErrorVariable "e"; $tracks
            }
        } | Select-Object -ExpandProperty items | Select-Object -ExpandProperty track -Property * -ExcludeProperty is_local,track,video_thumbnail

    }
}