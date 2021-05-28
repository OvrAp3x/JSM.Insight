
function Update-Object {
    [CmdletBinding()]
    param (
        [string]$ID,
        [string]$objectTypeId,
        [array]$attributesArray,
        [Bool]$hasAvatar,
        [string]$avatarUUID,
        [String]$Version = "1",
        [string]$InsightCreds = $InsightCreds,
        [string]$InsightWorkstationID = $InsightWorkstationID
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $Headers = New-Object 'System.Collections.Generic.Dictionary[[String],[String]]'
        $Headers.Add('content-type' , 'application/json')
        $Headers.Add('Authorization', 'Basic ' + $InsightCreds)
    }
    
    process {

        $RequestBody = @{
            'objectTypeId' = $objectTypeId
            'attributes'   = @($attributes)
            }

        $Request = [System.UriBuilder]"https://api.atlassian.com/jsm/insight/workspace/$InsightWorkstationID/v$Version/object/$id"
    }
    
    end {
        try {
            $response = Invoke-RestMethod -Uri $Request.Uri -Body $RequestBody -Headers $headers -Method PUT
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed"
            Write-Error -Message "$($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
        } 

        $response

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}