# 🛠 Fukuball 的 Mac 開發環境設定（dotfiles）

這是我的 macOS 開發環境設定備份，透過 Homebrew、dotfiles、symlink 和簡單腳本管理，讓我在新機快速還原開發環境。

---

## ✅ 快速開始（新電腦初始化步驟）

### 第 1 步：安裝 Homebrew

開啟 Terminal，執行：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

然後加入 shell path（Apple Silicon）：

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
```

確認 brew 可用：

```bash
brew doctor
```

---

## 第 2 步：安裝 Oh My Zsh

這個 dotfiles 假設你會使用 [Oh My Zsh](https://ohmyz.sh/)，並搭配內建的 robbyrussell 主題。

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

這份設定會提供乾淨、穩定的 zsh 體驗，並搭配 Git plugin 顯示當前 branch。

---

### 第 3 步：Clone 這個 dotfiles 專案

```bash
git clone git@github.com:fukuball/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

> 如果你沒用 SSH，可以改成：
> `git clone https://github.com/fukuball/dotfiles.git ~/dotfiles`

---

### 第 4 步：執行安裝腳本

```bash
cd ~/dotfiles
./install.sh
```

這會建立 symlink 到 `.zshrc`、`.gitconfig` 等設定檔。

---

### 第 5 步：安裝所有 Homebrew 套件

```bash
cd ~/dotfiles
brew bundle --file=./Brewfile
```

這會自動安裝我常用的 CLI 工具和 GUI app（如 Chrome、Brave 等）。

---

## 🔑 第 6 步：產生 SSH 金鑰並上傳至 GitHub

這支 dotfiles 提供了自動化腳本，可以快速產生 SSH key 並將其上傳至 GitHub：

```bash
cd ~/dotfiles
./ssh-setup.sh
```

這個腳本會自動：

- 建立 `~/.ssh/id_ed25519` 金鑰（若尚未存在）
- 加入 ssh-agent（macOS 上支援使用鑰匙圈）
- 使用 `gh` CLI 自動將公鑰上傳到你的 GitHub 帳號
- 金鑰會命名為：`你的電腦名稱-當前日期`

請確保你已登入 `gh` CLI：

```bash
gh auth login
```

執行完成後，你就可以在這台電腦用 SSH 方式 clone/push/pull GitHub 專案了。

---

---

## 🧙 一鍵還原新機環境

如果你在新電腦上，只需要執行以下一行指令，就可以自動完成：

- 安裝 Homebrew
- 安裝 git/gh/zsh 等工具
- Clone 你的 dotfiles
- 套用 symlink 設定與 macOS 偏好設定
- 安裝所有套件（Brewfile）
- 建立並上傳 SSH 金鑰至 GitHub

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/fukuball/dotfiles/main/bootstrap.sh)"
```

建議在 GitHub 上將你的 repo 設為 private，避免個人設定外洩。


## 🔧 已包含的設定檔

- `Brewfile`：所有使用 Homebrew 安裝的工具清單
- `gitconfig`：Git 使用者與格式設定
- `install.sh`：建立 symlink 的自動化腳本
- `macos.sh`：macOS 系統偏好設定自動化腳本
- `zshrc`：Shell 設定
- `ssh-setup.sh`：SSH 金鑰自動產生與上傳 GitHub 工具

---

## 📦 已安裝的套件清單（部份）

透過 `brew bundle` 安裝這些工具：

- CLI 工具：`fzf`, `gh`, `git`, `htop`, `neovim`, `zsh`...
- GUI 工具：`brave-browser`, `google-chrome`, `visual-studio-code`...

---

## 🚀 待辦（可選擇性擴充）

- 加入 VS Code 設定
- 加入 Node.js / Python 開發環境（如 `asdf` / `pyenv`）
- 加入 SSH Key / GitHub 設定腳本

---

## 🙌 Author

Fukuball Lin  
GitHub: [https://github.com/fukuball](https://github.com/fukuball)
