# ============================================
# REALISTIC AD ENVIRONMENT EXPANSION
# ============================================

$Global:Domain = (Get-ADDomain).DNSRoot
Write-Host "[*] Domain: $Global:Domain" -ForegroundColor Cyan

# 1. Create File Shares
Write-Host "`n[+] Creating department shares..." -ForegroundColor Green
$Shares = @{
    'IT_Share' = 'C:\Shares\IT'
    'Finance_Share' = 'C:\Shares\Finance'
    'HR_Share' = 'C:\Shares\HR'
    'Sales_Share' = 'C:\Shares\Sales'
}

foreach ($shareName in $Shares.Keys) {
    $path = $Shares[$shareName]
    New-Item -Path $path -ItemType Directory -Force | Out-Null
    
    # Create realistic files
    @"
Username: admin
Password: Winter2023!
Database: ProductionDB
"@ | Out-File "$path\config.txt"
    
    "Q1,Q2,Q3,Q4`n100000,120000,95000,150000" | Out-File "$path\revenue.csv"
    
    New-SmbShare -Name $shareName -Path $path -FullAccess "Everyone" -ErrorAction SilentlyContinue
}

# 2. Add Computers
Write-Host "[+] Adding computers..." -ForegroundColor Green
$Computers = @(
    'WKS-IT-001', 'WKS-IT-002', 'WKS-HR-001', 'WKS-FIN-001',
    'SRV-FILE01', 'SRV-SQL01', 'SRV-WEB01'
)

foreach ($comp in $Computers) {
    try {
        New-ADComputer -Name $comp -Enabled $true -ErrorAction SilentlyContinue
    } catch {}
}

# 3. Add GPOs
Write-Host "[+] Creating GPOs..." -ForegroundColor Green
Import-Module GroupPolicy
$GPOs = @('Password Policy', 'Workstation Security', 'Software Deployment')

foreach ($gpoName in $GPOs) {
    try {
        New-GPO -Name $gpoName -ErrorAction SilentlyContinue
    } catch {}
}

# 4. Add Service Account with SPN
Write-Host "[+] Creating service account..." -ForegroundColor Green
$sqlUser = "svc_mssql"
$sqlPass = "MSSQLService123!"

try {
    New-ADUser -Name "SQL Service" -SamAccountName $sqlUser `
               -UserPrincipalName "$sqlUser@$Global:Domain" `
               -AccountPassword (ConvertTo-SecureString $sqlPass -AsPlainText -Force) `
               -Enabled $true -Description "MSSQL Service Account" `
               -ErrorAction SilentlyContinue
    
    Set-ADUser -Identity $sqlUser -ServicePrincipalNames @{Add="MSSQLSvc/SQL01.$($Global:Domain):1433"}
} catch {}

Write-Host "`n[+] Realistic environment created!" -ForegroundColor Green
Write-Host "[*] Shares: $($Shares.Count)" -ForegroundColor Cyan
Write-Host "[*] Computers: $($Computers.Count)" -ForegroundColor Cyan
Write-Host "[*] GPOs: $($GPOs.Count)" -ForegroundColor Cyan
