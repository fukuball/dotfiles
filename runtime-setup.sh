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
if ! grep -q '.asdf' "$ZSHRC"; then
  echo "🔧 將 asdf 初始化加進 zshrc"
  {
    echo ''
    echo '# 初始化 asdf'
    echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"'
  } >> "$ZSHRC"
fi

# 安裝 asdf plugins
echo "🔌 安裝 plugins：nodejs, python"

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
asdf plugin add python https://github.com/danhper/asdf-python.git || true

# 安裝語言版本
echo "📥 安裝語言版本..."

# Node.js
asdf install nodejs 20.11.0
asdf install nodejs 18.19.1

# Python
asdf install python 3.12.1
asdf install python 2.7.18

# 建立 .tool-versions 檔案
echo "📄 寫入 .tool-versions"
cat <<EOF > ~/.tool-versions
nodejs 20.11.0 18.19.1
python 3.12.1 2.7.18
EOF

if [ -n "$ZSH_VERSION" ]; then
  echo "🔄 重新載入 zshrc..."
  source ~/.zshrc
else
  echo "⚠️ 目前是 bash，請手動執行：exec zsh"
fi

echo "✅ asdf 語言環境安裝完成，現在可以使用 asdf！"
