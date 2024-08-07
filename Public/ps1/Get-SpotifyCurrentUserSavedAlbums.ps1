function Get-SpotifyCurrentUserSavedAlbums {
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
        $albums = @{ next = "https://api.spotify.com/v1/me/albums?limit=50" }
        & { while($albums.next -and -Not $e){
                $albums = Invoke-RestMethod -Uri $albums.next -Method GET -Headers $header -ContentType "application/json" -ErrorVariable "e"; $albums
            } 
        } | Select-Object -ExpandProperty items | Select-Object -ExpandProperty album -Property * -ExcludeProperty album
    }

}