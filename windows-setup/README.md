# Windows Setup

This folder contains scripts and configurations for setting up Windows machines to my personal preferences.

## Step 1: Install Essential Programs

Open Windows PowerShell in **Administrator mode** and run the installation script:

```powershell
.\install-essential-programs.ps1
```

This script will automatically:

- Install Chocolatey (if not already installed)
- Install all essential programs:
  - 7-Zip
  - AutoHotkey
  - .NET Desktop Runtime 8
  - .NET Desktop Runtime 9
  - Firefox
  - Git
  - NuGet
  - Postman
  - PowerShell
  - PowerToys
  - Python3
  - VS Code

## Step 2: Apply Standard Tweaks with Chris Titus Tech Utility

Open Windows PowerShell in **Administrator mode** and execute the following command:

```powershell
irm "https://christitus.com/win" | iex
```

This will launch the Chris Titus Tech Windows Utility. For more information, check out the [WinUtil GitHub repository](https://github.com/ChrisTitusTech/winutil).

Once the utility is open:

1. Navigate to the **Tweaks** tab
2. Select the **Standard** preset configuration
3. Review the tweaks that will be applied
4. Click **Run Tweaks** to apply the standard configuration

## Step 3: Review and Customize Additional Preferences

Still in the Chris Titus Tech Windows Utility **Tweaks** tab:

1. Go through each category of tweaks
2. Review all available preferences
3. Customize any additional settings based on your personal requirements

You can also optionally install additional programs from the **Install** tab:

- Adobe Acrobat Reader
- Paint.NET
- qBittorrent
- VLC (Video Player)

## Step 4: Clone Repository and Apply Configurations

After installing Git in Step 1, clone the windows-setup repository:

```powershell
cd ~\Desktop
git clone https://github.com/MichaelPico/windows-setup.git
```

Navigate to the configuration folder and run the apply script to apply all saved configurations:

```powershell
cd windows-setup\configuration
.\apply-all.ps1
```

This will apply your saved configurations for:
- VS Code (settings, keybindings, snippets, and extensions)
- Git (global configuration)
- Azure CLI (configuration files)
