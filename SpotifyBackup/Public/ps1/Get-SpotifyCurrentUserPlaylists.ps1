
function Get-SpotifyCurrentUserPlaylists {
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
        $playlists = @{ next = "https://api.spotify.com/v1/me/playlists?limit=50" }
        & { while($playlists.next -and -Not $e){
                $playlists = Invoke-RestMethod -Uri $playlists.next -Method GET -Headers $header -ContentType "application/json" -ErrorVariable "e"; $playlists
            } 
        } | Select-Object -ExpandProperty items
    }

}