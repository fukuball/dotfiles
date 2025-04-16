#!/bin/bash

# 錯誤處理
set -euo pipefail
IFS=$'\n\t'

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 錯誤處理函數
error_exit() {
    echo -e "${RED}錯誤: $1${NC}" >&2
    exit 1
}

# 確認函數
confirm() {
    local message="$1"
    echo -e "${YELLOW}$message${NC} (y/N)"
    read -r response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# 備份檔案函數
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        echo -e "${YELLOW}備份 $file 到 ${file}.bak${NC}"
        cp "$file" "${file}.bak" || error_exit "無法備份 $file"
    fi
}

echo -e "${GREEN}🔗 開始設定 symlink...${NC}"

# 備份現有檔案
backup_file ~/.zshrc
backup_file ~/.gitconfig
backup_file ~/.tool-versions

# 建立 symlink
echo -e "${GREEN}建立 symlink...${NC}"
ln -sf ~/dotfiles/zshrc ~/.zshrc || error_exit "無法建立 .zshrc symlink"
ln -sf ~/dotfiles/gitconfig ~/.gitconfig || error_exit "無法建立 .gitconfig symlink"
ln -sf ~/dotfiles/tool-versions ~/.tool-versions || error_exit "無法建立 .tool-versions symlink"

echo -e "${GREEN}✅ symlink 設定完成${NC}"

# 確認是否要套用 macOS 系統偏好設定
if confirm "是否要套用 macOS 系統偏好設定？"; then
    echo -e "${GREEN}🍎 套用 macOS 系統偏好設定...${NC}"
    ./macos.sh || error_exit "執行 macos.sh 失敗"
fi

echo -e "${GREEN}✅ install.sh 執行完畢 🎉${NC}"
