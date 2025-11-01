
$host.UI.RawUI.WindowTitle = "Network Scanner"

Clear-Host

$ips = Get-NetIPAddress -AddressFamily IPv4 `
    | where-object IPAddress -ne "127.0.0.1" `
    | Where-object IPAddress -notlike "169.254.*" `


$ips `
    | Select-Object InterfaceIndex, InterfaceAlias `
    | Format-Table `
    | Write-Output

$InterfaceIndex = Read-Host "InterfaceIndex"

Clear-Host

$IPAddress = ($ips | Where-Object InterfaceIndex -eq $InterfaceIndex).IPAddress

$BaseIP = ($IPAddress.Split('.')[0..2] -join ".")

foreach ($X in 1..255) {

    Write-Host "$BaseIP.$x - " -NoNewline

    $conn = Test-Connection "$BaseIP.$x" -Count 1 -Quiet

    if ($conn) {
        Write-Host 'Online' -ForegroundColor Green
    } else {
        Write-Host 'Offline' -ForegroundColor Red
    }

}