Clear-Host

function Show-Menu {
    Write-Host " RUN THE POWERSHELL AS ADMIN, IF YOU DIDN'T OR IT WILL CAUSE PROBLEMS " -ForegroundColor Red
    Write-Host "" -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor DarkCyan
    Write-Host "         Zdravko Toolbox             " -ForegroundColor Green
    Write-Host "=====================================" -ForegroundColor DarkCyan
    Write-Host "[1] Clear Temp Files" -ForegroundColor White
    Write-Host "[2] Activate Windows/Office" -ForegroundColor White
    Write-Host "[3] Show PC Info" -ForegroundColor White
    Write-Host "[0] Exit" -ForegroundColor Red
    Write-Host "=====================================" -ForegroundColor DarkCyan
}

function Clear-TempFiles {
    Write-Host "Clearing Temp Files" -ForegroundColor Blue
    Remove-Item -Path "$env:Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\ProgramData\NVIDIA Corporation\NV_Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
    ipconfig /flushdns
}

function Show-PCInfoMenu {
    do {
        Clear-Host
        Write-Host "=====================================" -ForegroundColor DarkCyan
        Write-Host "         PC Information Menu             " -ForegroundColor Cyan
        Write-Host "=====================================" -ForegroundColor DarkCyan
        Write-Host "[1] Ram Info" -ForegroundColor White
        Write-Host "[2] GPU Info" -ForegroundColor White
        Write-Host "[3] Motherboard Info" -ForegroundColor White
        Write-Host "[4] CPU Info" -ForegroundColor White
        Write-Host "[5] Go Back To Main Menu" -ForegroundColor Red
        Write-Host "=====================================" -ForegroundColor DarkCyan
        $infoChoice = Read-Host "Select an Option"

        switch ($infoChoice) {
            "1" {
                Get-CimInstance Win32_PhysicalMemory | Select-Object Manufacturer, Speed, Capacity, PartNumber | Format-Table
                Pause
            }
            "2" {
                Get-CimInstance Win32_VideoController | Select-Object Name, DriverVersion, AdapterRAM | Format-Table
                Pause
            }
            "3" {
                Get-CimInstance Win32_BaseBoard | Select-Object Manufacturer, Product, SerialNumber | Format-Table
                Pause
            }
            "4" {
                Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, MaxClockSpeed | Format-Table
                Pause
            }
            "5" {
                return
            }
            Default {
                Write-Host "Invalid choice, please try again." -ForegroundColor Red
                Pause
            }
        }
    } while ($true)
}

function Activate-Windows {
    irm https://get.activated.win | iex
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Select an Option"
    switch ($choice) {
        "1" { Clear-TempFiles }
        "2" { Activate-Windows }
        "3" { Show-PCInfoMenu }
        "0" { exit }
        default { Write-Host "Invalid choice, please try again." -ForegroundColor Red }
    } 
        Write-Host 'Press Enter to continue...' -ForegroundColor DarkGray
        [void][System.Console]::ReadLine()
        Clear-Host
}

Read-Host -Prompt "Press Enter to exit..."
