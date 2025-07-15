#!/usr/bin/env bash

set -e

echo "🔧 Bootstrapping the project..."

# Copy .template files if the real ones don't exist
copy_template() {
  local src="$1"
  local dest="$2"
  if [ ! -f "$dest" ]; then
    cp "$src" "$dest"
    echo "✅ Created $dest from $src"
  else
    echo "⚠️  $dest already exists, skipping..."
  fi
}

mkdir -p .vscode .devcontainer

copy_template .vscode/settings.json.template .vscode/settings.json
copy_template .devcontainer/devcontainer.json.template .devcontainer/devcontainer.json

echo "✅ Bootstrap completed!"
