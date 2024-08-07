function Refresh-SpotifyAccessToken{

    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=0)]
        [Alias("RefreshToken")]
        [string]$refresh_token,
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=1)]
        [Alias("ClientId")]
        [string]$client_id,
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=2)]
        [Alias("ClientSecret")]
        [string]$client_secret
    )
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