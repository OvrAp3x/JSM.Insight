function New-InsightHeaders {
    param (
        [string]$InsightCreds = $InsightCreds,
        [switch]$ExperimentalApi
    )
    Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

    $Headers = New-Object 'System.Collections.Generic.Dictionary[[String],[String]]'
    $Headers.Add('content-type' , "application/json; charset=UTF-8")
    $Headers.Add('Authorization', 'Basic ' + $InsightCreds)

    if ($ExperimentalApi -eq $true) {
        $Headers.Add('X-ExperimentalApi', 'opt-in')
    }

    $Headers
}