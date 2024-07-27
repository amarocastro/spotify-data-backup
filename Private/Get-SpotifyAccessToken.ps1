
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


    #Check if refresh token needed
    # if($SpotifyRefreshTokenExpiresIn -lt (Get-Date)){
    #     # $headers = @{
    #     #     Authorization = "Basic $bearer"
    #     # }
    #     $body = @{
    #         grant_type = 'refresh_token'
    #         refresh_token = $SpotifyRefreshToken
    #         client_id = $SpotifyClientId
    #     }
    #     $refresh_token_request = Invoke-RestMethod -Uri 'https://accounts.spotify.com/api/token' -Method POST -ContentType 'application/x-www-form-urlencoded' -Body $body 
    #     $global:SpotifyAccessToken = $refresh_token_request.access_token
    #     $global:SpotifyRefreshToken = $refresh_token_request.refresh_token
    #     $global:SpotifyRefreshTokenExpiresIn = (Get-Date).AddSeconds([int]$access_token_request.expires_in)
    # }
}