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

# 2. 安裝必要工具
echo "🔧 安裝 CLI 工具 git / gh / zsh..."
brew install git gh zsh

# 3. 安裝 Oh My Zsh（如果尚未安裝）
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "🎩 安裝 Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh 已安裝"
fi

# 4. 登入 GitHub（如果尚未登入）
if ! gh auth status &>/dev/null; then
  echo "🧑‍💻 尚未登入 GitHub，請登入..."
  gh auth login
fi

# 5. SSH 金鑰設定（如果尚未存在）
echo "🔑 設定 SSH 金鑰..."
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "📦 尚未設定 SSH，下載並執行 ssh-setup.sh..."
  curl -fsSL https://raw.githubusercontent.com/fukuball/dotfiles/master/ssh-setup.sh | bash
else
  echo "✅ SSH 金鑰已存在，略過建立"
fi

# 6. 等待 GitHub 接受 SSH 金鑰
echo "⏳ 檢查 SSH 金鑰是否可用..."
until ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; do
  echo "🕐 等待 GitHub 接受 SSH 金鑰..."
  sleep 2
done
echo "🔐 SSH 認證通過！"

# 7. Clone dotfiles（如果尚未 clone）
if [ ! -d "$HOME/dotfiles" ]; then
  echo "📦 Clone dotfiles (via SSH)..."
  git clone git@github.com:fukuball/dotfiles.git ~/dotfiles
else
  echo "✅ dotfiles 資料夾已存在"
fi

cd ~/dotfiles

# 8. 建立 symlink + macOS 設定
echo "🔗 執行 install.sh..."
./install.sh

# 9. 安裝 Homebrew 套件
echo "📦 安裝 Brewfile 中的所有工具..."
brew bundle --file=./Brewfile

# 10. 安裝開發語言環境（Node.js / Python）
if [ -f "./runtime-setup.sh" ]; then
  echo "🔧 執行 runtime-setup.sh 安裝語言版本..."
  ./runtime-setup.sh
else
  echo "⚠️ 找不到 runtime-setup.sh，略過語言安裝"
fi

echo "🎉 所有步驟完成！歡迎回到熟悉的開發環境 😎"
