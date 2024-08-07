function Get-SpotifyAccessToken {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=0)]
        [Alias("AuthorizationCode")]
        [string]$authorization_code,
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=1)]
        [Alias("ClientId")]
        [string]$client_id,
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=2)]
        [Alias("ClientSecret")]
        [string]$client_secret
    )
    
    $cred_bytes = [System.Text.Encoding]::UTF8.GetBytes(($client_id+":"+$client_secret))
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