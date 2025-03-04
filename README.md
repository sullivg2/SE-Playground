# SE Playground

Welcome to **SE Playground**! This repository is dedicated to **Security Engineering (SE)**, focusing on **EDR testing, Incident Response (IR) playbooks, and security automation**.

## About This Repository
This repository serves as a **sandbox** for testing **Endpoint Detection and Response (EDR)** tools, running **incident response playbooks**, and exploring **security automation techniques**.

## What You’ll Find Here
- **EDR Testing Scripts** – Simulated attack scenarios and response evaluations.
- **Incident Response Playbooks** – Step-by-step response procedures for various security incidents.
- **Threat Hunting Guides** – Commands and workflows to detect malicious activity.
- **Security Automation** – Scripts to automate investigations and threat mitigation.

## Getting Started
### Clone the Repository
```sh
git clone https://github.com/your-username/SE-Playground.git
cd SE-Playground
```

### How to Use
- **EDR Tests**: Run scripts to validate EDR detection and response.
- **IR Playbooks**: Follow structured guides for incident investigation and containment.
- **Custom Security Tools**: Leverage automation to streamline security operations.

## Files in This Repository
### `incident_response_playbook.md`
This document contains a **CMD-based Incident Response Playbook**, which provides step-by-step commands for:
- Collecting system and process information
- Capturing network activity
- Identifying persistence mechanisms
- Analyzing security event logs
- Isolating compromised systems

### `Simulated-suspicious-activity-PowerShell.ps1`
This PowerShell script simulates **suspicious activity** designed to trigger alerts in EDR platforms. It helps test detection rules, visibility, and response capabilities. Key actions include:
- Executing encoded commands
- Modifying registry keys
- Simulating process injections or lateral movement

### `ir_response.bat`
A **batch script** that automates the **Incident Response Playbook** commands. Instead of running commands manually, execute this script to:
- Collect forensic artifacts
- Capture event logs and network connections
- Create a compressed archive of findings for further analysis

## EDR Testing Suite
The **EDR Testing Suite** is a collection of scripts designed to simulate different types of attack behaviors to test detection capabilities of Endpoint Detection and Response (EDR) solutions.

### `Invoke-EDR-Test.ps1`
This PowerShell script automates multiple suspicious activities to evaluate how an EDR solution detects and responds to:
- Encoded PowerShell execution
- Simulated credential dumping
- Process injection attempts
- Registry-based persistence techniques

### `Attack-Simulations/`
This folder contains individual attack simulation scripts:
- **CredentialDumping.ps1** – Simulates credential dumping techniques to test EDR detections.
- **ProcessInjection.ps1** – Simulates process injection using `rundll32`.
- **PersistenceTesting.ps1** – Simulates persistence mechanisms via registry modifications.

Each script logs test results to `C:\EDR-Testing\Logs` for further analysis.

## Contributions
Want to contribute? Feel free to submit a **Pull Request** with your own playbooks, scripts, or improvements!

## License
This repository is **open-source** and intended for research and educational purposes.

---
Stay Secure, Stay Vigilant!
