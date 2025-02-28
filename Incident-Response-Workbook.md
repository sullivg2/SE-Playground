# Incident Response Workbook (EDR Remote Shell)

## Overview
This repository contains structured incident response commands, playbooks, and automation scripts for responding to threats using an EDR remote shell.

## Repository Structure
```
Incident-Response-Workbook/
│── README.md                # Overview of the project
│── commands/                # Collection of categorized response commands
│   ├── process_investigation.md
│   ├── network_analysis.md
│   ├── containment_isolation.md
│── playbooks/               # Step-by-step guides for common incidents
│   ├── ransomware_response.md
│   ├── suspicious_processes.md
│── automation/              # Scripts for automation
│   ├── incident_response_demo.ps1
│── response-checklist.xlsx  # Excel checklist for live response tracking
│── .gitignore               # Ignore unnecessary files (logs, temp data, etc.)
```

---

## Commands
### Process Investigation
[View Full Document](commands/process_investigation.md)
```cmd
tasklist /v
```
- Lists all running processes (including details)

```cmd
taskkill /PID [PID] /F
```
- Terminates a suspicious process

### Network Analysis
[View Full Document](commands/network_analysis.md)
```cmd
netstat -ano
```
- Shows active network connections

```cmd
tasklist | findstr [PID]
```
- Finds the process associated with a network connection

### Containment & Isolation
[View Full Document](commands/containment_isolation.md)
```cmd
wmic nic where NetEnabled=true call Disable
```
- Disables network adapter (for isolating a compromised host)

---

## Playbooks
### Ransomware Response
[View Full Document](playbooks/ransomware_response.md)
**Steps:**
1. Identify affected processes (`tasklist /v`)
2. Kill suspicious processes (`taskkill /PID [PID] /F`)
3. Disable network (`wmic nic where NetEnabled=true call Disable`)
4. Locate encrypted files (`dir /s /t:c C:\Users`)
5. Restore from backup (if applicable)

### Suspicious Process Investigation
[View Full Document](playbooks/suspicious_processes.md)
**Steps:**
1. Check process details (`tasklist /v`)
2. Find network connections (`netstat -ano`)
3. Kill the process (`taskkill /PID [PID] /F`)
4. Remove persistence mechanisms (`reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run`)

---

## Automation
### Incident Response Demo Script
[View Full Document](automation/incident_response_demo.ps1)
```powershell
Write-Host "Incident Response Demo Starting..."

# Step 1: List Running Processes
Write-Host "Listing all processes..."
tasklist /v

# Step 2: Find Network Connections
Write-Host "Checking active network connections..."
netstat -ano

# Step 3: Prompt User for Process Investigation
$pid = Read-Host "Enter a suspicious PID to investigate"
tasklist | findstr $pid

# Step 4: Contain the Threat
$confirm = Read-Host "Do you want to kill the process? (Y/N)"
if ($confirm -eq "Y") {
    taskkill /PID $pid /F
    Write-Host "Process $pid terminated."
} else {
    Write-Host "Skipping termination."
}
```

---

## How to Use This Repository
1. **Clone the repository**
```sh
git clone https://github.com/yourusername/Incident-Response-Workbook.git
```
2. **Navigate to a section (commands, playbooks, automation)**
3. **Run commands manually or execute automation scripts**

---

## Contributing
- Open a pull request for updates
- Report issues or suggest improvements

---

📌 **Maintainer:** Geoff Sullivan