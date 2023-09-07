function Get-SWAPIFilm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]
        $Title
    )
    process {
        $invokeSwapiReqParams = @{
            Method = 'Get'
            Path   = 'films'
        }

        if ($PSBoundParameters.ContainsKey('Title')) {
            $invokeSwapiReqParams.Add('Query', @{ search = $Title })
        } 

        $ret = Invoke-SWAPIReq @invokeSwapiReqParams
        foreach ($r in $ret) {
            $r.PSObject.TypeNames.Insert(0,"SWAPI.Film")
        }
        $ret
    }
}
