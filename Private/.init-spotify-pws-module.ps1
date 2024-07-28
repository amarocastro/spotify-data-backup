Import-Module .\Private\Get-SpotifyAccessToken.ps1 -Force
Import-Module .\Private\Get-SpotifyAuthorization.ps1 -Force
Import-Module .\Private\Refresh-SpotifyAccessToken.ps1 -Force

function Init-Spotify-Module{

    #Populate available variables
    $all_vars = Get-Vars

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
        Save-Vars -authorization_code $authorization_code -access_token $access_token -refresh_token $refresh_token -expires_in $expires_in

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

function Get-Vars(){
    $content = Get-Content ".\Private\vars.json" | ConvertFrom-Json
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

function Set-Vars([string]$authorization_code,[string]$access_token,[string]$refresh_token,[string]$expires_in) {
    
    $global:SpotifyAuthCode = $authorization_code
    $global:SpotifyAccessToken = $access_token
    $global:SpotifyRefreshToken = $refresh_token
    $global:SpotifyAccessTokenDateExpires = $expires_in

}

function Save-Vars([string]$authorization_code,[string]$access_token,[string]$refresh_token,[string]$expires_in){

    $content = @{
        client_id = $SpotifyClientId
        secret = $SpotifyClientSecret 
        authorization_code = $authorization_code
        access_token = $access_token
        refresh_token = $refresh_token
        expires_in = $expires_in
    }

    $content | ConvertTo-Json | Set-Content ".\Private\vars.json"
    
}