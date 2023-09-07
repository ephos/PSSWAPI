function Get-SWAPIVehicle {
    [CmdletBinding(DefaultParameterSetName='Name')]
    param (
        [Parameter(Mandatory=$false, ParameterSetName='Name')]
        [string]
        $Name,

        [Parameter(Mandatory=$false, ParameterSetName='Model')]
        [string]
        $Model
    )
    process {
        $invokeSwapiReqParams = @{
            Method = 'Get'
            Path   = 'vehicles'
        } 

        if ($PSBoundParameters.ContainsKey('Name')) {
            $invokeSwapiReqParams.Add('Query', @{ search = $Name })
        } 
        if ($PSBoundParameters.ContainsKey('Model')) {
            $invokeSwapiReqParams.Add('Query', @{ search = $Model })
        } 

        $ret = Invoke-SWAPIReq @invokeSwapiReqParams
        foreach ($r in $ret) {
            $r.PSObject.TypeNames.Insert(0,"SWAPI.Vehicle")
        }
        $ret
    }
}
