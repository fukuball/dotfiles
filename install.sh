#!/bin/bash

echo "🔗 設定 symlink 中..."

ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig

echo "✅ symlink 設定完成"

echo "🍎 套用 macOS 系統偏好設定..."
./macos.sh

echo "✅ install.sh 執行完畢 🎉"

