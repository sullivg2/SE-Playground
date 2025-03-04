@echo off
setlocal ENABLEDELAYEDEXPANSION
set IR_DIR=C:\IR

:: Create IR directory
if not exist %IR_DIR% mkdir %IR_DIR%

echo [+] Gathering System Information...
systeminfo > %IR_DIR%\systeminfo.txt
hostname > %IR_DIR%\hostname.txt
whoami /all > %IR_DIR%\whoami.txt

echo [+] Listing Running Processes...
tasklist /v > %IR_DIR%\tasklist.txt
wmic process list full > %IR_DIR%\process_list.txt

echo [+] Capturing Network Information...
netstat -ano > %IR_DIR%\netstat.txt
ipconfig /all > %IR_DIR%\ipconfig.txt
arp -a > %IR_DIR%\arp_cache.txt
nslookup example.com > %IR_DIR%\dns_test.txt

echo [+] Capturing Logged-in Users & Sessions...
query user > %IR_DIR%\query_user.txt
net user > %IR_DIR%\net_user.txt
net localgroup administrators > %IR_DIR%\local_admins.txt

echo [+] Checking Startup & Persistence Mechanisms...
wmic startup get caption,command > %IR_DIR%\startup_items.txt
schtasks /query /fo LIST /v > %IR_DIR%\scheduled_tasks.txt
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run /s > %IR_DIR%\autoruns.txt

echo [+] Capturing Event Logs (Last 24 Hours)...
wevtutil qe Security /q:"*[System[(TimeCreated[timediff(@SystemTime) <= 86400000])]]" /f:text > %IR_DIR%\security_logs.txt
wevtutil qe System /q:"*[System[(TimeCreated[timediff(@SystemTime) <= 86400000])]]" /f:text > %IR_DIR%\system_logs.txt

echo [+] Capturing Active Network Connections...
netstat -ano | findstr ESTABLISHED > %IR_DIR%\established_connections.txt
netstat -ano | findstr LISTENING > %IR_DIR%\listening_ports.txt

:: Optional Containment - Uncomment if needed
:: echo [+] Isolating System...
:: netsh advfirewall set allprofiles state off
:: ipconfig /release

echo [+] Compressing Logs...
cd %IR_DIR%
tar -cvf IR_Logs.tar *

echo [!] Incident Response Data Collection Complete!
echo [!] Retrieve the logs from %IR_DIR%\IR_Logs.tar
endlocal
exit
