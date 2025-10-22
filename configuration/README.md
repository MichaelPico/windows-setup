# Configuration

This folder contains personal Windows configuration files and scripts to sync them between machines and this repository.

## VS Code

### Export Configuration

Run the import script to export your current VS Code configuration to the repository:

```powershell
.\vscode\import-config.ps1
```

This will export:

- Extension list to `extensions.txt`
- `settings.json`
- `keybindings.json`
- `snippets/` folder
