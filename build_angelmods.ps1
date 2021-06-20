$cwd = Get-Location
$factorioModFolder = "$($env:APPDATA)\Factorio\mods"

$mods = Get-ChildItem -Directory | Where-Object { $_.BaseName -match "angels" -and $_.BaseName -notmatch "liquidrobot" } | ForEach-Object { $_.BaseName }

foreach ($mod in $mods)
{
  $info = Get-Content -Raw -Path ("$($mod)\info.json") | ConvertFrom-Json

  Get-Childitem -Path ($factorioModFolder) -Filter ("$($info.name)*") | Where-Object { $_.Extension -eq ".zip" -and $_.BaseName.Split("_")[1] -ne $info.version } | ForEach-Object { $_.Delete() }

  New-Item -ItemType SymbolicLink -Path ("$($factorioModFolder)\$($info.name)_$($info.version)") -Target ("$($cwd)\$($mod)") -Force
}
