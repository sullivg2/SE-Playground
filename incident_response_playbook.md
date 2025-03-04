# 🛡️ CMD Incident Response Playbook
_A simple batch script for **incident response (IR) and forensic triage**, designed for execution via EDR’s remote shell._

---

## How to Use
### Option 1: Run Individual Commands
1. **Open CMD** (or use EDR’s remote shell).
2. **Run each command manually** as needed (listed below).

### Option 2: Create and Run a Batch Script
1. **Create a script file** (`ir_response.bat`).
2. **Upload it to the target machine** via EDR or a manual method.
3. **Run the script:**
   ```cmd
   C:\IR\ir_response.bat
   ```

---

## Writing Individual Scripts
If you cannot upload a batch script, you can manually create each script on the target machine.

### Create the Incident Response Directory
```cmd
mkdir C:\IR
```
_All collected logs will be stored in `C:\IR`._

### Gather System Information
```cmd
systeminfo > C:\IR\systeminfo.txt
hostname > C:\IR\hostname.txt
whoami /all > C:\IR\whoami.txt
```
🔍 **Review OS version, patch level, and logged-in user details.**

### Capture Running Processes
```cmd
tasklist /v > C:\IR\tasklist.txt
wmic process list full > C:\IR\process_list.txt
```
🔍 **Look for suspicious processes or abnormal resource usage.**

### Capture Network Information
```cmd
netstat -ano > C:\IR\netstat.txt
ipconfig /all > C:\IR\ipconfig.txt
arp -a > C:\IR\arp_cache.txt
nslookup example.com > C:\IR\dns_test.txt
```
🔍 **Identify unauthorized connections or altered network configurations.**

### Capture Logged-in Users & Sessions
```cmd
query user > C:\IR\query_user.txt
net user > C:\IR\net_user.txt
net localgroup administrators > C:\IR\local_admins.txt
```
🔍 **Detect unauthorized user accounts.**

### Check for Persistence Mechanisms
```cmd
wmic startup get caption,command > C:\IR\startup_items.txt
schtasks /query /fo LIST /v > C:\IR\scheduled_tasks.txt
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run /s > C:\IR\autoruns.txt
```
🔍 **Review scheduled tasks, startup items, and registry autoruns.**

### Capture Event Logs (Last 24 Hours)
```cmd
wevtutil qe Security /q:"*[System[(TimeCreated[timediff(@SystemTime) <= 86400000])]]" /f:text > C:\IR\security_logs.txt
wevtutil qe System /q:"*[System[(TimeCreated[timediff(@SystemTime) <= 86400000])]]" /f:text > C:\IR\system_logs.txt
```
🔍 **Look for failed logins, privilege escalation attempts, and unauthorized access.**

### Capture Active Network Connections
```cmd
netstat -ano | findstr ESTABLISHED > C:\IR\established_connections.txt
netstat -ano | findstr LISTENING > C:\IR\listening_ports.txt
```
🔍 **Find unexpected remote connections.**

### Optional: Isolate the System
```cmd
netsh advfirewall set allprofiles state off
ipconfig /release
```
**Use with caution**: This will disable the firewall and disconnect the network.

---

## Full Batch Script (`ir_response.bat`)
For automation, create and execute the following **batch script**:

```cmd
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
```

---

## Output Files
| **File** | **Description** |
|----------|---------------|
| `systeminfo.txt` | OS version, hostname, installed updates |
| `tasklist.txt` | Running processes (verbose details) |
| `netstat.txt` | Active network connections |
| `security_logs.txt` | Security event logs (last 24 hours) |
| `scheduled_tasks.txt` | Persistent scheduled tasks |
| `autoruns.txt` | Startup programs from registry |
| `IR_Logs.tar` | Compressed archive of all collected logs |

---

## References
- [Microsoft Sysinternals](https://docs.microsoft.com/en-us/sysinternals/)
- [Windows Forensic Analysis](https://docs.microsoft.com/en-us/windows/security/threat-protection/)
- [MITRE ATT&CK Framework](https://attack.mitre.org/)

