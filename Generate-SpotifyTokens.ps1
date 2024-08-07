function Generate-SpotifyTokens {

    $all_vars = Get-Vars -settings_path $privateFunctionsPath

    #If missing variables then request authorization
    if(-Not $all_vars){
        $authorization_code = Get-SpotifyAuthorization
        if(-Not $authorization_code){
            Throw "Missing authorization code"
        }
        $access_token_content = Get-SpotifyAccessToken -authorization_code $authorization_code
        if(-Not $access_token_content){
            Throw "Missing access token"
        }
        $access_token = $access_token_content.access_token
        $refresh_token = $access_token_content.refresh_token
        $expires_in = (Get-Date).AddSeconds([int]$access_token_content.expires_in)

        Set-Vars -authorization_code $authorization_code -access_token $access_token -refresh_token $refresh_token -expires_in $expires_in
        Save-Vars -settings_path $privateFunctionsPath -authorization_code $authorization_code -access_token $access_token -refresh_token $refresh_token -expires_in $expires_in

        $all_vars = $true
    }

    #Update token if expired
    $time_now = Get-Date
    if($time_now -gt $SpotifyAccessTokenDateExpires -and $all_vars){
        $refresh_token_content = Refresh-SpotifyAccessToken -client_id $SpotifyClientId -client_secret $SpotifyClientSecret -refresh_token $SpotifyRefreshToken
        if(-Not $refresh_token_content){
            Throw "Could not refresh your token"
        }
        $access_token = $refresh_token_content.access_token
        $expires_in = (Get-Date).AddSeconds([int]$refresh_token_content.expires_in)

        Set-Vars -authorization_code $SpotifyAuthCode -access_token $access_token -refresh_token $SpotifyRefreshToken -expires_in $expires_in
        Save-Vars -authorization_code $SpotifyAuthCode -access_token $access_token -refresh_token $SpotifyRefreshToken -expires_in $expires_in
    }
    
}