# Configuration

This folder contains personal Windows configuration files and scripts to sync them between machines and this repository.

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
