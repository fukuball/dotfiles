#!/bin/bash

if [ -z "$1" ]; then
  echo "❌ 請提供 Laravel 專案名稱"
  echo "用法：./sail-init.sh my-laravel-app"
  exit 1
fi

APP_NAME="$1"
APP_DIR="$HOME/Code/$APP_NAME"

echo "🚀 開始建立 Laravel 專案：$APP_NAME"
echo "📂 專案將建立於：$APP_DIR"

# 確保 ~/Code 資料夾存在
mkdir -p "$HOME/Code"

# 切換到 ~/Code 再執行建置
cd "$HOME/Code" || exit 1

# 使用 Laravel 官方建置腳本
curl -s "https://laravel.build/$APP_NAME" | bash

# 進入專案資料夾
cd "$APP_DIR" || exit 1

# 設定 .env（如尚未存在）
if [ ! -f ".env" ]; then
  echo "📄 建立 .env 檔案"
  cp .env.example .env
fi

# 建立 sail alias（僅加入一次）
if ! grep -q "alias sail=" ~/.zshrc; then
  echo "🔗 加入 sail alias 至 ~/.zshrc"
  echo 'alias sail="./vendor/bin/sail"' >> ~/.zshrc
  source ~/.zshrc
fi

# 啟動容器
echo "🐳 啟動 Laravel Sail..."
./vendor/bin/sail up -d

echo ""
echo "✅ Laravel 專案已建立並啟動完成！"
echo "📂 專案路徑：$APP_DIR"
echo "🌐 開啟 http://localhost"
echo ""
echo "👉 查看容器狀態：sail ps"
echo "👉 關閉容器：sail down"
