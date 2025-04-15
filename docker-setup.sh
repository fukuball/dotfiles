#!/bin/bash

echo "🐳 安裝 Docker Desktop for Mac..."

# 檢查是否為 Apple Silicon
IS_ARM=$(uname -m)
if [ "$IS_ARM" = "arm64" ]; then
  echo "✅ 偵測到 Apple Silicon (M1/M2/M3/M4)"
else
  echo "✅ 偵測到 Intel 架構"
fi

echo ""
echo "👉 將透過 Homebrew 安裝 Docker Desktop（含 CLI）..."
brew install --cask docker

echo ""
echo "📌 安裝完成後請手動啟動 Docker Desktop 並完成初始化："
echo "  - 開啟應用程式資料夾中的 Docker.app"
echo "  - 等待狀態變為 Running（右上角小鯨魚圖示）"
echo "  - 之後即可使用 docker / docker-compose 指令"

echo ""
echo "✅ 完成後可檢查版本："
echo "  docker --version"
echo "  docker compose version"

echo ""
echo "🎯 你可以現在執行以下指令來測試是否成功："
echo "  docker run hello-world"
