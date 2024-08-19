$access_token = "BQDfPhGdJYA3Fng_O4Gr_8vvXHdfx_uu7k_Up-Or3S43ak_OSfu8PrGT3RejkbKB7TsDEKHk9JY04FUcgHm2-wO7YO3y0LncW3YamXOnREhpRomofpyvSQ8gQWGLbZ-Bigjvhe3OGCxTMSciIAp9tdCkVdhgsu5Ub8tU6jQDkdkXmuMXAuSmwEt18VSX1SjRumPXB9uaYlUnYFaZ9pC6nRk"

$header = @{
    authorization = "Bearer " + $access_token
}

$artists = @{ next = "https://api.spotify.com/v1/me/following?type=artist&limit=50" }
        & { while($artists.next -and -Not $e){
                $artists = Invoke-RestMethod -Uri $artists.next -Method GET -Headers $header -ContentType "application/json" -ErrorVariable "e" | Select-Object -ExpandProperty artists; $artists
            } 
        } | Select-Object -ExpandProperty items