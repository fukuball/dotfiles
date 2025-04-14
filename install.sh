#!/bin/bash

# ⚠️ 如果有安裝 Oh My Zsh，這會覆蓋掉它產生的 ~/.zshrc
# 請確保在 Oh My Zsh 安裝完後執行本腳本

echo "🔗 設定 symlink 中..."

ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/tool-versions ~/.tool-versions

echo "✅ symlink 設定完成"

echo "🍎 套用 macOS 系統偏好設定..."
./macos.sh

echo "✅ install.sh 執行完畢 🎉"
