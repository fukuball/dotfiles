#!/bin/bash

echo "🚀 啟動 dotfiles restore 流程..."

# 1. 安裝 Homebrew（如果尚未安裝）
if ! command -v brew >/dev/null 2>&1; then
  echo "🧪 安裝 Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew 已安裝"
fi

# 2. 安裝 git / gh / zsh（如果尚未安裝）
echo "🔧 安裝必要 CLI 工具..."
brew install git gh zsh

# 3. Clone dotfiles（如果尚未 clone）
if [ ! -d "$HOME/dotfiles" ]; then
  echo "📦 Clone dotfiles..."
  git clone git@github.com:fukuball/dotfiles.git ~/dotfiles
else
  echo "✅ dotfiles 資料夾已存在"
fi

cd ~/dotfiles

# 4. 執行安裝腳本（建立 symlink + macOS 設定）
echo "🔗 執行 install.sh..."
./install.sh

# 5. 安裝 Homebrew 套件
echo "📦 安裝 Brewfile 中的所有工具..."
brew bundle --file=./Brewfile

# 6. 建立 SSH key 並上傳 GitHub（若尚未登入 gh CLI 會提示）
echo "🔑 設定 SSH 金鑰並上傳至 GitHub..."
./ssh-setup.sh

echo "🎉 所有步驟完成！歡迎回到熟悉的開發環境 😎"

