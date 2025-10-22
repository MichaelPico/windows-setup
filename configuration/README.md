# Configuration

This folder contains personal Windows configuration files and scripts to sync them between machines and this repository.

## Quick Start

### Import All Configurations (Save to Repo)

Export all configurations to the repository:

```powershell
.\import-all.ps1
```

### Export All Configurations (Apply from Repo)

Apply all configurations from the repository to your machine:

```powershell
.\export-all.ps1
```

## VS Code

### Import Configuration (Save to Repo)

Export your current VS Code configuration to the repository:

```powershell
.\vscode\import-config.ps1
```

This will export:

- Extension list to `extensions.txt`
- `settings.json`
- `keybindings.json`
- `snippets/` folder

### Export Configuration (Apply from Repo)

Apply VS Code configuration from the repository to your machine:

```powershell
.\vscode\export-config.ps1
```

This will:

- Copy `settings.json` and `keybindings.json` to `%APPDATA%\Code\User`
- Copy snippets folder
- Install all extensions from `extensions.txt`

## Git

### Import Configuration (Save to Repo)

Export your current Git global configuration to the repository:

```powershell
.\git\import-config.ps1
```

This will export `.gitconfig` from your user profile.

### Export Configuration (Apply from Repo)

Apply Git global configuration from the repository to your machine:

```powershell
.\git\export-config.ps1
```

This will copy `.gitconfig` to `%USERPROFILE%\.gitconfig`

## Azure CLI

### Import Configuration (Save to Repo)

Export your current Azure CLI configuration to the repository:

```powershell
.\azure-cli\import-config.ps1
```

This will export `config` and `clouds.config` from `%USERPROFILE%\.azure`

### Export Configuration (Apply from Repo)

Apply Azure CLI configuration from the repository to your machine:

```powershell
.\azure-cli\export-config.ps1
```

This will copy configuration files to `%USERPROFILE%\.azure`
