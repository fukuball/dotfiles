#!/bin/bash

echo "🚀 開始安裝 asdf 與常用語言版本..."

# 安裝 asdf（透過 brew）
if ! command -v asdf >/dev/null 2>&1; then
  echo "📦 安裝 asdf..."
  brew install asdf
else
  echo "✅ 已安裝 asdf"
fi

# 加入 zsh 設定（如果尚未加入）
ZSHRC=~/dotfiles/zshrc
if ! grep -q 'asdf.sh' "$ZSHRC"; then
  echo "🔧 將 asdf 初始化加進 zshrc"
  {
    echo ''
    echo '# 初始化 asdf'
    echo '. /opt/homebrew/opt/asdf/libexec/asdf.sh'
  } >> "$ZSHRC"
fi

# 安裝 asdf plugins
echo "🔌 安裝 plugins：nodejs, python, php"

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
asdf plugin add python https://github.com/danhper/asdf-python.git || true
asdf plugin add php https://github.com/asdf-community/asdf-php.git || true

# 安裝語言版本
echo "📥 安裝語言版本..."

# Node.js
asdf install nodejs 20.11.0
asdf install nodejs 18.19.1
asdf global nodejs 20.11.0

# Python
asdf install python 3.12.1
asdf install python 2.7.18
asdf global python 3.12.1

# PHP
asdf install php 8.2.12
asdf install php 7.4.33
asdf global php 8.2.12

# 建立 .tool-versions 檔案
echo "📄 寫入 .tool-versions"
cat <<EOF > ~/.tool-versions
nodejs 20.11.0 18.19.1
python 3.12.1 2.7.18
php 8.2.12 7.4.33
EOF

echo "🔄 重新載入 zshrc..."
source ~/.zshrc

echo "✅ asdf 語言環境安裝完成，現在可以使用 asdf！"
