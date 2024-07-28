function Refresh-SpotifyAccessToken($client_id,$client_secret,$refresh_token){
       
    # $headers = @{
    #     Authorization = "Basic $bearer"
    # }
    $body = @{
        grant_type = 'refresh_token'
        refresh_token = $refresh_token
        client_id = $client_id
        client_secret = $client_secret
    }
    $refresh_token_content = Invoke-RestMethod -Uri 'https://accounts.spotify.com/api/token' -Method POST -ContentType 'application/x-www-form-urlencoded' -Body $body
    return $refresh_token_content
}