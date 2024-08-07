function Get-SpotifyAuthorization {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=0)]
        [Alias("ClientId")]
        [string]$client_id
    )

    $redirect_uri = "http://localhost:8124/callback/"
    $scope = 'user-read-private user-read-email user-library-read user-follow-read'
    $state = -join ((65..90) + (97..122) | Get-Random -Count 16 | % {[char]$_})

    $spotifyAuthUrl = "https://accounts.spotify.com/authorize/"
    $spotifyAuthUrl += "?client_id=$client_id"
    $spotifyAuthUrl += "&response_type=code"
    $spotifyAuthUrl += "&redirect_uri=$([System.Uri]::EscapeDataString($redirect_uri))"
    # $spotifyAuthUrl += "&redirect_uri=$redirect_uri"
    $spotifyAuthUrl += "&scope=$scope"
    $spotifyAuthUrl += "&state=$state"
    $spotifyAuthUrl += "&show_dialog=true"

    $authorization_code = $null

    Start-Process $spotifyAuthUrl
    $listener = New-Object System.Net.HttpListener
    $listener.Prefixes.Add($redirect_uri)

    try{
        $listener.Start()

        if($listener.IsListening){
            $context = $listener.GetContext()
            $request = $context.Request
            $response = $context.Response

            $response_body = ''

            if ($request.QueryString['Exit'] -ne $null) {
                $response_body = '<html><h1>Bad Request</h1></html>'
                $response.StatusCode = 400
                Write-Error 'Bad Request : Listener exit requested.'
            }
            # If needed check the state code to ensure everything is on the up and up.
            elseif (($State.Length -gt 0) -and ($Request.QueryString['state'] -ne $State)) {
                $response_body = '<html><h1>Bad Request</h1></html>'
                $response.StatusCode = 400
                Write-Error 'Bad Request : State does not match.'
            }
            # If there was an error, report it.
            elseif ($request.QueryString['error'].Length -gt 0) {
                $response_body = '<html><h1>Unauthorized</h1></html>'
                $response.StatusCode = 401
                Write-Error "Authorization Error : $(request.QueryString['error'])"
            }
            # No errors so far...grab the access code if present.
            elseif ($request.QueryString['code'].Length -gt 0) {
                $authorization_code = $request.QueryString['code']
                $response_body = '<html><h1>Application Registered</h1></html>' 
            }

            # Throw error if no code exist.
            else {
                $response_body = '<html><h1>Bad Request</h1></html>'
                $response.StatusCode = 400
                Write-Error 'Bad Request : No access code found.'
            }

            # Return the HTML to the caller.
            $buffer = [Text.Encoding]::UTF8.GetBytes($response)
            $response.ContentLength64 = $buffer.length
            $response.OutputStream.Write($buffer, 0, $buffer.length)
            $response.Close()
        }
    } finally{
        $listener.Stop()
    }
    
    return $authorization_code
}



