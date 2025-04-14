#!/bin/bash

echo "⚙️ 設定 macOS 偏好設定..."

# 關閉開機聲，有需要可以用
# sudo nvram SystemAudioVolume=" "

# 顯示所有副檔名
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder 顯示路徑列
defaults write com.apple.finder ShowPathbar -bool true

# Finder 預設開啟 Downloads 資料夾
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

# Dock：自動隱藏，動畫加速
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.2

# 鍵盤快速重複
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 5

# 啟用 tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# 停用自動拼字校正
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# 重啟必要服務，套用設定
killall Finder
killall Dock
killall SystemUIServer  # menu bar / 輸入法等更新

echo "✅ macOS 設定完成"

