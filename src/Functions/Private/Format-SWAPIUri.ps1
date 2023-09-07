function Format-SWAPIUri {
    [CmdletBinding()]
    param (
        # Endpoint to access (needs to be relative)
        [Parameter(Mandatory=$true)]
        [Uri]
        $Path,

        # One or more relative Uri / query parameters
        [Parameter(Mandatory=$false)]
        [Hashtable]
        $Query
    )

    process {
        $swapiBaseUri = 'https://swapi.dev/'

        if (-not ([Uri]::IsWellFormedUriString($swapiBaseUri, [System.UriKind]::Absolute))) {
            Write-Error -Category InvalidArgument -Exception "Provided base Uri ($swapiBaseUri) was not an absolute URI." -ErrorAction Stop
        }
        if (-not ([Uri]::IsWellFormedUriString($Endpoint, [System.UriKind]::Relative))) {
            Write-Error -Category InvalidArgument -Exception "Provided endpoint ($Endpoint) was not a relative URI." -ErrorAction Stop
        }

        $uriBuilder = [System.UriBuilder]::new($swapiBaseUri)
        $uriBuilder.Path = "api/$Path"

        # Remove the port, doesn't need to be explicitly added.
        $uriBuilder.Port = -1

        if ($PSBoundParameters.ContainsKey('Query')) {
            $q = [System.Web.HttpUtility]::ParseQueryString($uriBuilder.Query)

            foreach ($i in $Query.GetEnumerator()) {
                $q.Add($i.Key, $i.Value)
            }

            $uriBuilder.Query = $q.ToString()
        }

        $uri = $uriBuilder.ToString()

        if (-not ([Uri]::IsWellFormedUriString($uri, [System.UriKind]::Absolute))){
            Write-Error -Category InvalidData -Exception "Assembled URI was ($uri) was invalid." -ErrorAction Stop
        }

        # Write out the assembled URI
        $uri
    }
}
