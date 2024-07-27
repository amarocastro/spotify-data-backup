Import-Module .\Private\Get-SpotifyAccessToken.ps1 -Force
Import-Module .\Private\Get-SpotifyAuthorization.ps1 -Force

function Init-Module() {

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
        $expire_in = (Get-Date).AddSeconds([int]$access_token_content.expires_in)

        Set-Vars -authorization_code $authorization_code -access_token $access_token -refresh_token $refresh_token -expire_in $expire_in
        Save-Vars -authorization_code $authorization_code -access_token $access_token -refresh_token $refresh_token -expire_in $expire_in
    }

    #Update token if expired
    
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
        $global:SpotifyAccessTokenDateExpires = $content.expires
        
        $all_vars = $true
    }

    return $all_vars
}

function Set-Vars([string]$authorization_code,[string]$access_token,[string]$refresh_token,[string]$expire_in) {
    
    $global:SpotifyAuthCode = $authorization_code
    $global:SpotifyAccessToken = $access_token
    $global:SpotifyRefreshToken = $refresh_token
    $global:SpotifyAccessTokenDateExpires = $expires_in

}

function Save-Vars([string]$authorization_code,[string]$access_token,[string]$refresh_token,[string]$expire_in){

    $content = @{
        client_id = $SpotifyClientId
        secret = $SpotifyClientSecret 
        authorization_code = $authorization_code
        access_token = $access_token
        refresh_token = $refresh_token
        #Guardar como datetime
        expires = $expires_in
    }

    $content | ConvertTo-Json | Set-Content ".\Private\vars.json"
    
}