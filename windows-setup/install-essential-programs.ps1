# Install Essential Programs with Chocolatey
# This script installs all essential programs for Windows setup

Write-Host "Installing Essential Programs with Chocolatey..." -ForegroundColor Cyan
Write-Host ""

# Check if Chocolatey is installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey is not installed. Installing Chocolatey first..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    # Refresh environment variables
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Host "Chocolatey installed successfully!" -ForegroundColor Green
    Write-Host ""
}

# List of programs to install
$programs = @(
    '7zip',
    'autohotkey',
    'dotnet-desktopruntime',
    'dotnet-9.0-desktopruntime',
    'firefox',
    'git',
    'nuget.commandline',
    'postman',
    'powershell-core',
    'powertoys',
    'python3',
    'vscode'
)

# Interactive selection
Write-Host "Select programs to install (press SPACE to toggle, ENTER to confirm):" -ForegroundColor Cyan
Write-Host "  [UP/DOWN] Navigate  [SPACE] Toggle  [ENTER] Confirm" -ForegroundColor DarkGray
Write-Host ""

$selected = @($true) * $programs.Count
$cursor = 0

function Draw-Menu {
    param($programs, $selected, $cursor)
    for ($i = 0; $i -lt $programs.Count; $i++) {
        $check = if ($selected[$i]) { "[X]" } else { "[ ]" }
        $color = if ($i -eq $cursor) { "Yellow" } else { "White" }
        $prefix = if ($i -eq $cursor) { "> " } else { "  " }
        Write-Host "$prefix$check $($programs[$i])" -ForegroundColor $color
    }
}

# Hide cursor for cleaner UI
[Console]::CursorVisible = $false

Draw-Menu $programs $selected $cursor

while ($true) {
    $key = [Console]::ReadKey($true)

    $redraw = $false

    switch ($key.Key) {
        'UpArrow' {
            if ($cursor -gt 0) { $cursor--; $redraw = $true }
        }
        'DownArrow' {
            if ($cursor -lt $programs.Count - 1) { $cursor++; $redraw = $true }
        }
        'Spacebar' {
            $selected[$cursor] = -not $selected[$cursor]; $redraw = $true
        }
        'Enter' {
            break
        }
    }

    if ($key.Key -eq 'Enter') { break }

    if ($redraw) {
        [Console]::SetCursorPosition(0, [Console]::CursorTop - $programs.Count)
        Draw-Menu $programs $selected $cursor
    }
}

[Console]::CursorVisible = $true
Write-Host ""

$toInstall = for ($i = 0; $i -lt $programs.Count; $i++) {
    if ($selected[$i]) { $programs[$i] }
}

if ($toInstall.Count -eq 0) {
    Write-Host "No programs selected. Exiting." -ForegroundColor Yellow
    exit
}

Write-Host "The following programs will be installed:" -ForegroundColor Cyan
$toInstall | ForEach-Object { Write-Host "  - $_" }
Write-Host ""

# Install each program
foreach ($program in $toInstall) {
    Write-Host "Installing $program..." -ForegroundColor Yellow
    choco install $program -y
    Write-Host ""
}

Write-Host "All selected programs have been installed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Note: You may need to restart your terminal or computer for all changes to take effect." -ForegroundColor Yellow
