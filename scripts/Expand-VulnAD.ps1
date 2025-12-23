# Load names array
$Global:HumansNames = @('Aaren', 'Aarika', 'Abagael', 'Abagail', 'Abbe', 'Abbey', 'Abbi', 'Abbie', 'Abby', 'Abbye', 'Abigael', 'Abigail', 'Abigale', 'Abra', 'Ada', 'Adah', 'Adaline', 'Adan', 'Adara', 'Adda', 'Addi', 'Addia', 'Addie', 'Addy', 'Adel', 'Adela', 'Adelaida', 'Adelaide', 'Adele', 'Adelheid', 'Adelice', 'Adelina', 'Adelind', 'Adeline', 'Adella', 'Adelle', 'Adena', 'Adey', 'Adi', 'Adiana', 'Adina', 'Adora', 'Adore', 'Adoree', 'Adorne', 'Adrea', 'Adria', 'Adriaens', 'Adrian', 'Adriana', 'Adriane', 'Adrianna', 'Adrianne', 'Adriena', 'Adrienne', 'Aeriel', 'Aeriela', 'Aeriell', 'Afton', 'Kennie', 'Kennith', 'Kenny', 'Kevin', 'Kyle', 'Larry', 'Lee', 'Leo', 'Leon', 'Leonard', 'Liam', 'Logan', 'Louis', 'Lucas', 'Luke', 'Marcus', 'Mark', 'Martin', 'Mason', 'Matthew', 'Max', 'Michael', 'Nathan', 'Nicholas', 'Noah', 'Oliver', 'Oscar', 'Owen', 'Patrick', 'Paul', 'Peter', 'Philip', 'Richard', 'Robert', 'Ryan', 'Samuel', 'Sean', 'Sebastian', 'Simon', 'Stephen', 'Steven', 'Thomas', 'Timothy', 'Tyler', 'Victor', 'Vincent', 'Walter', 'William', 'Zachary')

Add-Type -AssemblyName System.Web

# Set your domain - CHANGE THIS!
$Global:Domain = "vuln.local"

Write-Host "[+] Adding more users..." -ForegroundColor Green
for ($i = 1; $i -le 100; $i++) {
    $firstName = Get-Random -InputObject $Global:HumansNames
    $lastName = Get-Random -InputObject $Global:HumansNames
    $sam = "$firstName.$lastName".ToLower()
    $pass = [System.Web.Security.Membership]::GeneratePassword(12,2)
    
    try {
        New-ADUser -Name "$firstName $lastName" -GivenName $firstName -Surname $lastName `
                   -SamAccountName $sam -UserPrincipalName "$sam@$Global:Domain" `
                   -AccountPassword (ConvertTo-SecureString $pass -AsPlainText -Force) `
                   -Enabled $true -ErrorAction SilentlyContinue
    } catch {}
}

Write-Host "[+] Adding more groups..." -ForegroundColor Green
$NewGroups = @('DevTeam', 'QATeam', 'Support', 'Contractors', 'Interns', 
               'RemoteWorkers', 'VIPUsers', 'Developers', 'Testers')

foreach ($group in $NewGroups) {
    try {
        New-ADGroup -Name $group -GroupScope Global -ErrorAction SilentlyContinue
    } catch {}
    
    $allUsers = (Get-ADUser -Filter *).SamAccountName
    $selectedUsers = Get-Random -InputObject $allUsers -Count (Get-Random -Minimum 5 -Maximum 25)
    foreach ($user in $selectedUsers) {
        try {
            Add-ADGroupMember -Identity $group -Members $user -ErrorAction SilentlyContinue
        } catch {}
    }
}

Write-Host "[+] Expansion complete!" -ForegroundColor Green
Write-Host "[*] Total Users: $((Get-ADUser -Filter *).Count)" -ForegroundColor Cyan
Write-Host "[*] Total Groups: $((Get-ADGroup -Filter *).Count)" -ForegroundColor Cyan
