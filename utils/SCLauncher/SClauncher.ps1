# Script to stop EAC services when launching Star Citizen.
# ---------------------------------------------------------------------
# Path and name of the config file
$configFile="$PSScriptRoot\SClauncher.ini"
#
# .--------------------------------------------------------------------.
# |                   END OF CONFIG DO NOT EDIT AFTER                  |
# '--------------------------------------------------------------------'
#
if (!(Test-Path $configFile -PathType leaf)) {
  Write-Host "Error: SClauncher.ini not found!" -BackgroundColor Black -ForegroundColor Red
  Start-Sleep -seconds 10
  exit
}
Get-Content $configFile | foreach-object -begin {$h=@{}} -process {
	$k = [regex]::split($_,'=')
	if (($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) {
		$h.Add($k[0], $k[1])
	}
}
if (!(Test-Path $h.Launcher -PathType leaf)) {
  Write-Host $h.Launcher
  Write-Host "Error: Star Citizen Launcher not found! Please edit the Launcher path in SClauncher.ini" -BackgroundColor Black -ForegroundColor Red
  Start-Sleep -seconds 10
  #exit
}
# Declare a list of services to be stoped
$serviceNames = ($h.EAC,$h.EOS)
Write-Host '>> START SC LAUNCHER <<' -BackgroundColor White -ForegroundColor DarkRed
Write-Host ''
# Star Launcher
Start-Process -FilePath $h.Launcher -RedirectStandardOutput "NUL" -Passthru | Out-Null
$started = $false
$status = (Get-Process -Name $h.lnProc -ErrorAction SilentlyContinue).id
do { # Loop until Star Citizen launcher is started
	$status = (Get-Process -Name $h.lnProc -ErrorAction SilentlyContinue).id
	if (!($status)) {
		Start-Sleep -Seconds 1
	} else {
		$started = $true
	}
}
until ($started)

do {
	$gms = (Get-Process -Name $h.scProc -ErrorAction SilentlyContinue).id
	if (!($gms)) {
		# Loop until Star Citizen game is started
		Write-Host '>> WAIT FOR STAR CITIZEN <<' -BackgroundColor White -ForegroundColor DarkRed
		Write-Host ''
		$started = $false
		$status = (Get-Process -Name $h.scProc -ErrorAction SilentlyContinue).id
		do {
			$lns = (Get-Process -Name $h.lnProc -ErrorAction SilentlyContinue).id
			if (!($lns)) {
				$stoped = $true
				break
			}
			$status = (Get-Process -Name $h.scProc -ErrorAction SilentlyContinue).id
			if (!($status)) {
				Start-Sleep -Seconds 1
			} else {
				$started = $true
			}
		}
		until ($started)
	}
	if ($stoped) { break }
	Write-Host '>> WAIT FOR EAC <<' -BackgroundColor White -ForegroundColor DarkRed
	Write-Host ''
	do {
		$gms = (Get-Process -Name $h.scProc -ErrorAction SilentlyContinue).id
		if (!($gms)) { break } 							# If game is stoped, get our of the loop
		foreach ($serviceName in $serviceNames) { 		# for each services
			$service = Get-Service -Name $serviceName
			while ($service -ne 'Running') {			# if the service has a status not equal to running
				if ($service.Status -eq 'Stopped') { 	# if it is stoped then get out of the loop
					break
				}
				else { # else stop the service
					Write-Host $service.DisplayName "Detected" -BackgroundColor Black -ForegroundColor Red
					Start-Sleep -Seconds $h.KillTimer
					Stop-Service $ServiceName
					$service.Refresh()
					Write-Host $service.DisplayName $service.Status -BackgroundColor DarkGray -ForegroundColor White
					Write-Host ''
				}
			}
		}
		Start-Sleep -Seconds 5
	}
	until($stoped)
}
until($stoped)
