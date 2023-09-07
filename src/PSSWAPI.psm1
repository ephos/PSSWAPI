# Unblock files if Windows.
if ($PSVersionTable.Platform -eq 'Windows') {
    Get-ChildItem -Path $PSScriptRoot -Recurse | Unblock-File
}

# Dot source classes.
# Get-ChildItem -Path $PSScriptRoot\Classes\*.ps1 | Foreach-Object { . $_.FullName }

# Dot source public functions.
Get-ChildItem -Path $PSScriptRoot\Functions\Public\*.ps1 | Foreach-Object { . $_.FullName }

# Dot source private functions.
Get-ChildItem -Path $PSScriptRoot\Functions\Private\*.ps1 | Foreach-Object { . $_.FullName }

# PS1XML to customize output.
Update-FormatData -PrependPath $PSScriptRoot\Format\swapi.format.ps1xml

# Argument completion.
# If needed will go here.  Comment stub, deal with it.
