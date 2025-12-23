# AD Lab Setup Scripts

This directory contains PowerShell scripts used to build and configure the AD lab environment.

## Setup Scripts

### Expand-VulnAD.ps1
Creates a realistic AD environment with 100 users and multiple groups.

**Features:**
- Generates 100 users with random first and last names
- Creates 9 security groups (DevTeam, QATeam, Support, etc.)
- Randomly assigns 5-25 users to each group
- Uses secure random password generation

**Usage:**
```powershell
# Update the domain variable first!
$Global:Domain = "root.lab"  

# Run the script on the Domain Controller
.\Expand-VulnAD.ps1
```

**Requirements:**
- Must be run on Domain Controller
- Requires Domain Admin privileges
- Active Directory PowerShell module

---

### Create-RealisticAD.ps1
Adds realistic infrastructure components to simulate a production environment.

**Features:**
- **File Shares**: Creates 4 department shares (IT, Finance, HR, Sales) with sample files
- **Computers**: Adds 7 computer objects (workstations and servers)
- **GPOs**: Creates 3 Group Policy Objects
- **Service Account**: Creates SQL service account with SPN (Kerberoastable)

**Created Resources:**
- Network shares with weak permissions (Everyone - Full Access)
- Sample configuration files with credentials
- Service account: `svc_mssql` with password `MSSQLService123!`
- SPN: `MSSQLSvc/SQL01.vuln.local:1433`

**Usage:**
```powershell
# Run on the Domain Controller
.\Create-RealisticAD.ps1
```

**Requirements:**
- Must be run on Domain Controller
- Requires Domain Admin privileges
- Active Directory and GroupPolicy PowerShell modules

---

## Security Testing Notes

⚠️ **These scripts intentionally create vulnerabilities for testing purposes:**

1. **Kerberoasting**: Service account with SPN and weak password
2. **Weak Permissions**: SMB shares with Everyone - Full Access
3. **Credential Exposure**: Config files with plaintext credentials
4. **Password Patterns**: Predictable password format

## Execution Order

For initial lab setup, run in this order:
1. `Expand-VulnAD.ps1` - Creates user base
2. `Create-RealisticAD.ps1` - Adds infrastructure

## Customization

Before running, review and modify:
- Domain names (`$Global:Domain`)
- User/group names
- Share paths
- Service account credentials

---
⚠️ **Use only in isolated lab environments. Never in production.**
