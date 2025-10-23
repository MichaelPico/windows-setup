# Configuration

This folder contains personal Windows configuration files and scripts to sync them between machines and this repository.

## Quick Start

### Save All Configurations (Machine → Repo)

Save all configurations from your machine to the repository:

```powershell
.\save-all.ps1
```

### Apply All Configurations (Repo → Machine)

Apply all configurations from the repository to your machine:

```powershell
.\apply-all.ps1
```

## VS Code

### Save Configuration (Machine → Repo)

Save your current VS Code configuration to the repository:

```powershell
.\vscode\save-config.ps1
```

This will save:

- Extension list to `extensions.txt`
- `settings.json`
- `keybindings.json`
- `snippets/` folder

### Apply Configuration (Repo → Machine)

Apply VS Code configuration from the repository to your machine:

```powershell
.\vscode\apply-config.ps1
```

This will:

- Copy `settings.json` and `keybindings.json` to `%APPDATA%\Code\User`
- Copy snippets folder
- Install all extensions from `extensions.txt`

## Git

### Save Configuration (Machine → Repo)

Save your current Git global configuration to the repository:

```powershell
.\git\save-config.ps1
```

This will save `.gitconfig` from your user profile.

### Apply Configuration (Repo → Machine)

Apply Git global configuration from the repository to your machine:

```powershell
.\git\apply-config.ps1
```

This will copy `.gitconfig` to `%USERPROFILE%\.gitconfig`

## Azure CLI

### Save Configuration (Machine → Repo)

Save your current Azure CLI configuration to the repository:

```powershell
.\azure-cli\save-config.ps1
```

This will save `config` and `clouds.config` from `%USERPROFILE%\.azure`

### Apply Configuration (Repo → Machine)

Apply Azure CLI configuration from the repository to your machine:

```powershell
.\azure-cli\apply-config.ps1
```

This will copy configuration files to `%USERPROFILE%\.azure`
