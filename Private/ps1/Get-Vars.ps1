function Get-Vars([string]$settings_path){
    $content = Get-Content "$settings_path\vars.json" | ConvertFrom-Json
    $global:SpotifyClientId = $content.client_id
    $global:SpotifyClientSecret = $content.secret
    $all_vars = $false
    if($content.authorization_code){
        $global:SpotifyAuthCode = $content.authorization_code
    }
    if($content.authorization_code -and       
        $content.access_token -and
        $content.refresh_token -and
        $content.expires_in){

        $global:SpotifyAuthCode = $content.authorization_code
        $global:SpotifyAccessToken = $content.access_token
        $global:SpotifyRefreshToken = $content.refresh_token
        ##Convertir en datetime
        $global:SpotifyAccessTokenDateExpires = [Datetime]$content.expires_in
        
        $all_vars = $true
    }

    return $all_vars
}