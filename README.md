# Active Directory Lab

## Overview
This lab was created to learn Active Directory fundamentals and how to exploit common vulnerabilities in AD environments. The project provided hands-on experience with offensive security tools including **BloodHound**, **NetExec**, **Impacket**, and **Mimikatz** while understanding how Active Directory can be attacked and defended.

## Repository Structure

```
├── README.md                           # This file
├── AD_attacks_documentation.pdf        # Detailed findings and attack documentation
├── diagrams/                           # Network and AD topology diagrams
├── scripts/                            # PowerShell and other automation scripts

```

## Lab Environment

### Components
- **Domain Controller**: Windows Server 2022 (192.168.56.10/24)
- **Workstation**: Windows 10 Domain Member (192.168.56.20/24)
- **Attacker Machine**: Kali Linux with dual adapters (192.168.56.200/24 + NAT)
- **Network**: Isolated Host-Only network for DC and workstation, NAT for Kali internet access
- **Domain**: root.lab
Vulnerabilities Configured

The following vulnerabilities were intentionally configured for testing:

- **Abusing ACLs/ACEs** - Dangerous delegations and GenericAll permissions
- **Kerberoasting** - Service accounts with SPNs and weak passwords
- **AS-REP Roasting** - Users without Kerberos preauthentication
- **DNSAdmins Abuse** - Users added to DNSAdmins group
- **Password in Description** - Credentials stored in user object descriptions
- **DCSync Attack** - Replicating Directory Changes permissions granted
- **SMB Signing Disabled** - Lack of SMB signing on clients and servers
### Tools Used

- **BloodHound** - AD relationship mapping and attack path analysis
- **NetExec** - Network enumeration and exploitation
- **Impacket** - Python classes for working with network protocols
- **Mimikatz** - Credential extraction tool

### Prerequisites
- Virtualization platform (VMware/VirtualBox/Hyper-V)
- Windows Server ISO
- Windows Client ISO
- Sufficient hardware resources (RAM, Storage)


*Last Updated: December 2025*
