    <#
    .SYNOPSIS
    Get organiztion client ID and secret from user.json and generates JWT token.

    .EXAMPLE
    $JWT = Get-JWTToken
    
    .AUTHOR
    Martin Miles
    #>
    [CmdletBinding()]
    Param()

$userJson = ..\Security\Read-UserJson.ps1

$clientId = $userJson.endpoints.xmCloud.clientId
$clientSecret = $userJson.endpoints.xmCloud.clientSecret
$authorityUrl = $userJson.endpoints.xmCloud.authority
$audience = $userJson.endpoints.xmCloud.audience
$grantType = "client_credentials"

$body = @{
    client_id = $clientId
    client_secret = $clientSecret
    audience = $audience
    grant_type = $grantType
} 

$response = Invoke-RestMethod -Uri "${authorityUrl}oauth/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $body
return $response.access_token
