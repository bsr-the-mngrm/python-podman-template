Write-Host "🔧 Bootstrapping the project..."

function Copy-IfMissing {
    param (
        [string]$src,
        [string]$dest
    )
    if (-Not (Test-Path $dest)) {
        Copy-Item $src $dest
        Write-Host "✅ Created $dest from $src"
    } else {
        Write-Host "⚠️  $dest already exists, skipping..."
    }
}

New-Item -ItemType Directory -Force -Path .vscode | Out-Null
New-Item -ItemType Directory -Force -Path .devcontainer | Out-Null

Copy-IfMissing ".vscode/settings.json.template" ".vscode/settings.json"
Copy-IfMissing ".devcontainer/devcontainer.json.template" ".devcontainer/devcontainer.json"

Write-Host "✅ Bootstrap completed!"
