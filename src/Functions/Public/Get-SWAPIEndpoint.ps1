function Get-SWAPIEndpoint {
    [CmdletBinding()]
    param ()
    process {
        Invoke-SWAPIReq -Method Get -Path ''
    }
}
