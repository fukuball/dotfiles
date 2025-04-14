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

# 3. 登入 GitHub（如果尚未登入）
if ! gh auth status &>/dev/null; then
  echo "🧑‍💻 尚未登入 GitHub，請登入..."
  gh auth login
fi

# 4. 產生並上傳 SSH 金鑰
echo "🔑 執行 SSH 金鑰設定..."
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "📦 尚未設定 SSH，執行 ssh-setup.sh 前置..."
  curl -fsSL https://raw.githubusercontent.com/fukuball/dotfiles/main/ssh-setup.sh | bash
else
  echo "✅ SSH key 已存在，略過建立"
fi

# 5. 等待 GitHub 接受 SSH 金鑰
echo "⏳ 檢查 SSH 金鑰是否可用..."
until ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; do
  echo "🕐 等待 GitHub 接受 SSH 金鑰..."
  sleep 2
done
echo "🔐 SSH 認證通過！"

# 6. Clone dotfiles（如果尚未 clone）
if [ ! -d "$HOME/dotfiles" ]; then
  echo "📦 Clone dotfiles (via SSH)..."
  git clone git@github.com:fukuball/dotfiles.git ~/dotfiles
else
  echo "✅ dotfiles 資料夾已存在"
fi

cd ~/dotfiles

# 7. 執行安裝腳本（建立 symlink + macOS 設定）
echo "🔗 執行 install.sh..."
./install.sh

# 8. 安裝 Homebrew 套件
echo "📦 安裝 Brewfile 中的所有工具..."
brew bundle --file=./Brewfile

echo "🎉 所有步驟完成！歡迎回到熟悉的開發環境 😎"
