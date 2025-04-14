#!/bin/bash

echo "🧠 開始設定 VS Code 環境..."

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
DOTFILES_VSCODE_DIR="$HOME/dotfiles/vscode"

# Step 1: 確保 VS Code 設定資料夾存在
echo "📂 確認 VS Code 設定資料夾是否存在..."
mkdir -p "$VSCODE_USER_DIR"

# Step 2: 建立 settings.json symlink
if [ -f "$DOTFILES_VSCODE_DIR/settings.json" ]; then
  echo "🔗 設定 symlink：settings.json"
  ln -sf "$DOTFILES_VSCODE_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"
else
  echo "⚠️ 找不到 settings.json，略過 symlink"
fi

# Step 3: 安裝 extensions
if [ -f "$DOTFILES_VSCODE_DIR/extensions.txt" ]; then
  echo "📦 安裝 extensions.txt 中列出的 VS Code 擴充套件..."
  cat "$DOTFILES_VSCODE_DIR/extensions.txt" | xargs -n 1 code --install-extension
else
  echo "⚠️ 找不到 extensions.txt，略過擴充套件安裝"
fi

# Step 4: 套用 keybindings.json
if [ -f "$DOTFILES_VSCODE_DIR/keybindings.json" ]; then
  echo "🔗 設定 symlink：keybindings.json"
  ln -sf "$DOTFILES_VSCODE_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
else
  echo "ℹ️ 若將來加入 keybindings.json，這裡會自動套用"
fi

echo "✅ VS Code 設定完成 🎉"
