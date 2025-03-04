# ProcessInjection.ps1
# Simulates process injection techniques to test EDR detections
# FOR SECURITY TESTING ONLY

$LogFile = "C:\EDR-Testing\Logs\ProcessInjection-Test.log"
New-Item -ItemType Directory -Path "C:\EDR-Testing\Logs" -ErrorAction SilentlyContinue

Function Write-Log {
    param ([string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$Timestamp - $Message" | Out-File -Append -FilePath $LogFile
}

Write-Log "[TEST] Simulating Process Injection..."

# Simulation of process injection using rundll32 (non-functional, used for detection testing)
cmd.exe /c "rundll32.exe C:\Windows\System32\notepad.exe,CreateProcessA" > nul

Write-Log "[TEST] Process Injection Test Completed. Review $LogFile for results."
Write-Host "Process Injection Simulation Completed."
