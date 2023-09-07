function Get-SWAPIPlanet {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]
        $Name
    )
    process {
        $invokeSwapiReqParams = @{
            Method = 'Get'
            Path   = 'planets'
        }

        if ($PSBoundParameters.ContainsKey('Name')) {
            $invokeSwapiReqParams.Add('Query', @{ search = $Name })
        } 

        $ret = Invoke-SWAPIReq @invokeSwapiReqParams
        foreach ($r in $ret) {
            $r.PSObject.TypeNames.Insert(0,"SWAPI.Planet")
        }
        $ret
    }
}
