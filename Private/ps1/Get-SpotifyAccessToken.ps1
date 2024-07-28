function Get-SpotifyAccessToken([string]$authorization_code) {

    $cred_bytes = [System.Text.Encoding]::UTF8.GetBytes(($SpotifyClientId+":"+$SpotifyClientSecret))
    $bearer = [Convert]::ToBase64String($cred_bytes)
    
    $headers = @{
        Authorization = "Basic $bearer"
    }
    $body = @{
        grant_type = 'authorization_code'
        code = $authorization_code
        redirect_uri = 'http://localhost:8124/callback/'
    }

    $access_token_request = Invoke-RestMethod -Uri 'https://accounts.spotify.com/api/token' -Method POST -Headers $headers -ContentType 'application/x-www-form-urlencoded' -Body $body 
    
    return $access_token_request

}