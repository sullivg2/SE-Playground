# Simulated suspicious activity PowerShell script

# Simulating an encoded payload execution (often flagged by EDR)
$encodedCommand = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes("Write-Host 'EDR Test Script Executed'"))
Start-Process powershell -ArgumentList "-EncodedCommand $encodedCommand"

# Simulated execution of an unsigned script from memory (often a detection trigger)
$scriptBlock = { Write-Host "In-Memory Execution Test" }
Invoke-Command -ScriptBlock $scriptBlock

# Simulated persistence method (typically flagged)
$taskName = "EDRDetectionTestTask"
$taskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "'Write-Host Scheduled Task Test'"
$taskTrigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(5)
Register-ScheduledTask -TaskName $taskName -Action $taskAction -Trigger $taskTrigger -User "NT AUTHORITY\SYSTEM" -RunLevel Highest -Force

Write-Host "Test script executed, check EDR logs for detections."

# Clean up after execution (optional)
Start-Sleep -Seconds 5
Unregister-ScheduledTask -TaskName $taskName -Confirm:$false




taskkill /IM powershell.exe /