Clear-Host

function Show-Menu {
    Write-Host " RUN THE POWERSHELL AS ADMIN, IF YOU DIDN'T OR IT WILL CAUSE PROBLEMS " -ForegroundColor Red
    Write-Host "" -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor DarkCyan
    Write-Host "         Zdravko Toolbox             " -ForegroundColor Green
    Write-Host "=====================================" -ForegroundColor DarkCyan
    Write-Host "[1] Clear Temp Files" -ForegroundColor White
    Write-Host "[2] Activate Windows/Office" -ForegroundColor White
    Write-Host "[0] Exit" -ForegroundColor Red
    Write-Host "=====================================" -ForegroundColor DarkCyan
}

function Clear-TempFiles {
    Write-Host "Clearing Temp Files" -ForegroundColor Blue
    Remove-Item -Path "$env:Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\ProgramData\NVIDIA Corporation\NV_Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
}

function Activate-Windows {
    irm https://get.activated.win | iex
}

while ($true) {
    Show-Menu
    $choice = Read-Host "select an option"
    switch ($choice) {
        "1" { Clear-TempFiles }
        "2" { Activate-Windows }
        "0" { exit }
        default { Write-Host "Invalid choice, please try again." -ForegroundColor Red }
    } 
    Write-Host 'Press Enter to continue...' -ForegroundColor DarkGray
    [void][System.Console]::ReadLine()
    Clear-Host
}

Read-Host -Prompt "Press Enter to exit..."
