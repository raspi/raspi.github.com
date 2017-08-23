param (
    [Parameter(Mandatory=$true)][string]$releaseDir
)

$releaseDir = Resolve-Path "$releaseDir"

if(![System.IO.Directory]::Exists("$releaseDir")) {
  Write-Host "Directory not found."
  Exit 1
}

Push-Location "$PSScriptRoot"

Push-Location "$releaseDir"

Get-ChildItem -Path "." -Exclude ".git" | foreach ($_) {
  Write-Host "Removing '$_.fullname'"
  Remove-Item $_.fullname -Force -Recurse
}

Pop-Location

$fpath = "$pwd\content"

Get-ChildItem "content" -Filter "*.md" -Recurse | ForEach-Object {
	$fname = $_.FullName
	$dtime = ($_.LastWriteTimeUtc | Get-Date -Format s)

	Write-Host "Reading file '$fname'."
	$lines = (Get-Content "$fname" -Encoding UTF8)
	$len = $lines.Count
	
	for ($i = 0; $i -lt $len; $i++) {
		$line = $lines[$i]
		
		if ($line.StartsWith('date:')) {
			Write-Host "Replacing date line '$line' with '$dtime'"
			$lines[$i] = 'date: {0}+03:00' -f $dtime
		}
		
	}

	Write-Host "Saving file '$fname'."
	$lines | Set-Content "$fname" -Encoding UTF8
	Write-Host ""
}

C:\hugo\hugo.exe --verbose --destination "$releaseDir"