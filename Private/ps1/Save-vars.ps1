function Save-Vars([string]$settings_path,[string]$authorization_code,[string]$access_token,[string]$refresh_token,[string]$expires_in){

    $content = @{
        client_id = $SpotifyClientId
        secret = $SpotifyClientSecret 
        authorization_code = $authorization_code
        access_token = $access_token
        refresh_token = $refresh_token
        expires_in = $expires_in
    }

    $content | ConvertTo-Json | Set-Content ".\vars.json"
    
}