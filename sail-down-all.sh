#!/bin/bash

echo "🔍 偵測 Laravel Sail 專案中..."

FOUND=0

while read -r SAIL_PATH; do
  if [ -x "$SAIL_PATH" ]; then
    PROJECT_DIR="$(dirname "$(dirname "$(dirname "$SAIL_PATH")")")"
    echo "🛑 關閉：$PROJECT_DIR"
    (cd "$PROJECT_DIR" && ./vendor/bin/sail down)
    FOUND=1
  else
    echo "⚠️  跳過：$SAIL_PATH 不是可執行的 sail"
  fi
done < <(find "$HOME/Code" -maxdepth 4 -path "*/vendor/bin/sail")

if [ "$FOUND" = 0 ]; then
  echo "❌ 找不到任何 Sail 專案"
else
  echo ""
  echo "✅ 所有 Laravel Sail 專案容器已停止"
fi
