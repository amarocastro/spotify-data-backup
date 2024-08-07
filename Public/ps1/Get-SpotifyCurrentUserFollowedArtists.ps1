function Get-SpotifyCurrentUserFollowedArtists {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=0)]
        [Alias("AccesToken")]
        [string]$access_token
    )
    process{
        $header = @{
            authorization = "Bearer " + $access_token
        }
        $artists = @{ next = "https://api.spotify.com/v1/me/following?type=artist&limit=50" }
        & { while($artists.next -and -Not $e){
                $artists = Invoke-RestMethod -Uri $artists.next -Method GET -Headers $header -ContentType "application/json" -ErrorVariable "e" | Select-Object -ExpandProperty artists; $artists
            } 
        } | Select-Object -ExpandProperty items
    }
}