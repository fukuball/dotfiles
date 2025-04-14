#!/bin/bash

echo "🔗 設定 symlink 中..."

ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig

echo "✅ symlink 設定完成"

# Optional: 之後可以加更多設定，例如 asdf、brew 套件等
