# AD Lab Network Topology

## Network Overview
This lab uses an isolated Host-Only network (192.168.56.0/24) for the AD environment, with the Kali attacker having dual network adapters for both isolation and internet access.

## Network Diagram

```
                                    Internet
                                       |
                                       |
                                   [NAT Gateway]
                                       |
                                       |
        ┌──────────────────────────────┴──────────────────────────────┐
        |                                                              |
        |                Host-Only Network: 192.168.56.0/24            |
        |                        (Isolated Lab)                        |
        |                                                              |
        |                                                              |
        |  ┌─────────────────────┐      ┌─────────────────────┐      |
        |  │  Domain Controller  │      │   Workstation VM    │      |
        |  │                     │      │                     │      |
        |  │  Windows Server     │◄────►│   Windows 10        │      |
        |  │  2022               │      │                     │      |
        |  │                     │      │   Domain Member     │      |
        |  │  IP: 192.168.56.10  │      │   IP: 192.168.56.20 │      |
        |  │  Role: DC, DNS, AD  │      │                     │      |
        |  └─────────────────────┘      └─────────────────────┘      |
        |            ▲                            ▲                    |
        |            │                            │                    |
        |            │         AD Traffic         │                    |
        |            │      & Attack Vectors      │                    |
        |            │                            │                    |
        |            └────────────┬───────────────┘                    |
        |                         │                                    |
        |                         ▼                                    |
        |              ┌─────────────────────┐                         |
        |              │   Kali Linux        │                         |
        |              │   Attacker Machine  │                         |
        |              │                     │                         |
        |              │  Adapter 1 (eth0):  │                         |
        |              │  192.168.56.200     │                         |
        |              │  (Host-Only)        │                         |
        |              │                     │                         |
        |              │  Adapter 2 (eth1):  │─────────────────────────┘
        |              │  NAT - Internet     │
        |              │  (Tool Downloads)   │
        |              └─────────────────────┘
        |
        └───────────────────────────────────────────────────────────────

```

## Component Details

### Domain Controller (DC)
- **Hostname**: DC.root.lab
- **Operating System**: Windows Server 2022
- **IP Address**: 192.168.56.10/24
- **Network Adapter**: Host-Only Adapter
- **Roles**: 
  - Active Directory Domain Services (AD DS)
  - DNS Server
  - Domain Controller
- **Internet Access**: None (Isolated)

### Workstation VM
- **Hostname**: DESKTOP.root.lab
- **Operating System**: Windows 10
- **IP Address**: 192.168.56.20/24
- **Network Adapter**: Host-Only Adapter
- **Domain Status**: Domain Member
- **Internet Access**: None (Isolated)

### Kali Linux Attacker
- **Hostname**: kali
- **Operating System**: Kali Linux
- **Network Adapters**:
  - **Adapter 1 (eth0)**: Host-Only - 192.168.56.200/24
  - **Adapter 2 (eth1)**: NAT (Internet connectivity)
- **Purpose**: Security testing and attack simulation
- **Internet Access**: Yes (via NAT adapter)

## Network Configuration

### Host-Only Network (192.168.56.0/24)
- **Purpose**: Isolated AD lab environment
- **Subnet Mask**: 255.255.255.0
- **Gateway**: N/A (isolated)
- **DNS Server**: 192.168.56.10 (DC)

### IP Address Allocation
| Device           | IP Address       | Role           |
|------------------|------------------|----------------|
| Domain Controller| 192.168.56.10    | DC, DNS        |
| Workstation      | 192.168.56.20    | Domain Member  |
| Kali Attacker    | 192.168.56.200   | Penetration Testing |

## Security Considerations

### Network Isolation
- ✅ DC and Workstation are fully isolated from the internet
- ✅ Kali machine has controlled internet access via separate NAT adapter
- ✅ Host-Only network prevents accidental exposure to external networks

### Attack Surface
- DC is accessible from Kali on the Host-Only network
- Workstation is accessible from Kali on the Host-Only network
- All attack vectors are contained within the isolated lab


---
*Network configured for security research and education purposes only.*
