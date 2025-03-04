# Invoke-EDR-Test.ps1
# Simulates various suspicious activities to test EDR detections including encoded commands, credential dumping simulation, process injection and registry persistence
# USE THIS SCRIPT FOR SECURITY TESTING ONLY

$LogFile = "C:\EDR-Testing\Logs\EDR-Test-Results.log"
New-Item -ItemType Directory -Path "C:\EDR-Testing\Logs" -ErrorAction SilentlyContinue

Function Write-Log {
    param ([string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$Timestamp - $Message" | Out-File -Append -FilePath $LogFile
}

Write-Log "Starting EDR Test Suite..."

# 1️⃣ Basic Suspicious Execution
Write-Log "[TEST] Running Suspicious Execution..."
Start-Process -NoNewWindow cmd.exe -ArgumentList "/c echo Suspicious Execution Detected"

# 2️⃣ Encoded PowerShell Command
Write-Log "[TEST] Running Encoded PowerShell Command..."
$encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes("Write-Output 'Suspicious Encoded Command'"))
powershell.exe -EncodedCommand $encodedCommand

# 3️⃣ Simulated Credential Dumping
Write-Log "[TEST] Simulating Credential Dumping..."
cmd.exe /c "echo Dumping LSASS Memory (Simulated)" > nul

# 4️⃣ Process Injection Simulation
Write-Log "[TEST] Simulating Process Injection..."
cmd.exe /c "rundll32.exe C:\Windows\System32\notepad.exe,CreateProcessA" > nul

# 5️⃣ Registry Persistence Test
Write-Log "[TEST] Creating Suspicious Registry Key for Persistence..."
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v "EDR_Test" /t REG_SZ /d "C:\Windows\System32\calc.exe" /f

Write-Log "EDR Test Suite Completed. Review $LogFile for results."

Write-Host "EDR Test Suite Execution Completed."
