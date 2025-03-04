# PersistenceTesting.ps1
# Simulates persistence mechanisms to test EDR detections
# FOR SECURITY TESTING ONLY

$LogFile = "C:\EDR-Testing\Logs\Persistence-Test.log"
New-Item -ItemType Directory -Path "C:\EDR-Testing\Logs" -ErrorAction SilentlyContinue

Function Write-Log {
    param ([string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$Timestamp - $Message" | Out-File -Append -FilePath $LogFile
}

Write-Log "[TEST] Simulating Persistence Mechanisms..."

# Adding a registry key for persistence (test case, non-malicious)
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v "Persistence_Test" /t REG_SZ /d "C:\Windows\System32\calc.exe" /f

Write-Log "[TEST] Persistence Test Completed. Review $LogFile for results."
Write-Host "Persistence Simulation Completed."
