#!/bin/bash

KEY_FILE="$HOME/.ssh/id_ed25519"
EMAIL="fukuball@gmail.com"  # <-- 改成你的 GitHub 註冊信箱

echo "🔐 設定 SSH Key..."

# Step 1: 檢查是否已有 key
if [ -f "$KEY_FILE" ]; then
  echo "✅ SSH key 已存在：$KEY_FILE"
else
  echo "📦 建立新的 SSH key..."
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_FILE" -N ""
fi

# Step 2: 啟用 agent 並加載 key
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain "$KEY_FILE" 2>/dev/null || ssh-add "$KEY_FILE"

# Step 3: 確保 ~/.ssh/config 設定 UseKeychain
CONFIG_FILE="$HOME/.ssh/config"
if ! grep -q "UseKeychain yes" "$CONFIG_FILE" 2>/dev/null; then
  echo "🛠️ 設定 ~/.ssh/config..."
  mkdir -p ~/.ssh
  {
    echo "Host github.com"
    echo "  AddKeysToAgent yes"
    echo "  UseKeychain yes"
    echo "  IdentityFile ~/.ssh/id_ed25519"
  } >> "$CONFIG_FILE"
  echo "✅ 已加入 UseKeychain 設定"
else
  echo "✅ ~/.ssh/config 已含 UseKeychain 設定"
fi

# Step 4: 上傳至 GitHub（需登入過 gh）
echo "☁️ 上傳 public key 到 GitHub..."
gh ssh-key add "${KEY_FILE}.pub" --title "$(hostname)-$(date +%Y%m%d_%H%M)"

echo "🎉 SSH 設定完成！"
