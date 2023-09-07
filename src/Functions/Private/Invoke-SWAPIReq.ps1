function Invoke-SWAPIReq {
    [CmdletBinding()]
    param (
        # HTTP Method
        [Parameter(Mandatory=$true)]
        [ValidateSet('Get')]
        [string]
        $Method,

        # Endpoint to access (needs to be relative)
        [Parameter(Mandatory=$true)]
        [Uri]
        $Path,

        # One or more relative Uri / query parameters
        [Parameter(Mandatory=$false)]
        [Hashtable]
        $Query,

        # Return as Wookiee 
        [Parameter(Mandatory=$false)]
        [switch]
        $AsWookie
    )
    
    process {

        $formatSwapiUriParams = @{
            Path = $Path
        }

        if ($PSBoundParameters.ContainsKey('Query')) {
            $formatSwapiUriParams.Add('Query', $Query)

            if ($AsWookie) {
                $Query.Add('format', 'wookiee')
            }
        }

        $uri = Format-SWAPIURI @formatSwapiUriParams

        $invokeRestMethodParams = @{
            Method = $Method
            Uri = $uri
            FollowRelLink = $true
            ErrorAction = 'Stop'
        }

        Write-Verbose -message "Invoking REST method with parameters: $($invokeRestMethodParams | Out-String)"
        $ret = Invoke-RestMethod @invokeRestMethodParams

        # Turn the page... you wash your hands... you turn the page... you wash your hands...
        # There may be a better way to do this but this seems to fly for now.
        # I don't think SWAPI follows RFC 5988, so we need to do this manually :'(
        
        if ($ret.next) {
            $resultList = [System.Collections.Generic.List[PSCustomObject]]::new()
            foreach ($r in $ret.results) {
                $resultList.Add($r)
            }

            while (-not [string]::IsNullOrEmpty($ret.next)) {
               $ret = Invoke-RestMethod -Uri $ret.next
               foreach ($r in $ret.results) {
                   $resultList.Add($r)
               }
            }

            $resultList

        } else {
            $ret.results
        }
    }
}
