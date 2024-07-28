function Set-Vars([string]$authorization_code,[string]$access_token,[string]$refresh_token,[string]$expires_in) {
    
    $global:SpotifyAuthCode = $authorization_code
    $global:SpotifyAccessToken = $access_token
    $global:SpotifyRefreshToken = $refresh_token
    $global:SpotifyAccessTokenDateExpires = $expires_in

}