# 🛠 Fukuball 的 Mac 開發環境設定（dotfiles）

這是針對 macOS 打造的個人開發環境 dotfiles，透過 Homebrew、symlink 與 Shell 腳本快速完成環境還原。

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
eval "$(/opt/homebrew/bin/brew shellenv)"
```

> 📁 備註：本流程會將 Homebrew shellenv 加入 `~/.zprofile`，確保 Apple Silicon 使用者能正常載入 `brew`。

確認 brew 可用：

```bash
brew doctor
```

---

### 第 2 步：安裝 Oh My Zsh

這個 dotfiles 假設你會使用 [Oh My Zsh](https://ohmyz.sh/)，並搭配內建的 robbyrussell 主題。

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

這份設定會提供乾淨、穩定的 zsh 體驗，並搭配 Git plugin 顯示當前 branch。

---

### 第 3 步：安裝必要工具

```bash
brew install git gh zsh
```

---

### 第 4 步：登入 GitHub（如果尚未登入）

```bash
gh auth login
```

---

### 第 5 步：產生 SSH 金鑰並上傳至 GitHub

> 💡 本腳本會自動設定 macOS 的 ssh-agent 和 `~/.ssh/config`，讓你未來 push/pull 不再需要重複輸入密碼。

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

### 第 6 步：Clone 這個 dotfiles 專案

```bash
git clone git@github.com:fukuball/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

> 如果你沒用 SSH，可以改成：
> `git clone https://github.com/fukuball/dotfiles.git ~/dotfiles`

---

### 第 7 步：執行安裝腳本

```bash
cd ~/dotfiles
./install.sh
```

這會建立 symlink 到 `.zshrc`、`.gitconfig` 等設定檔。

---

### 第 8 步：安裝所有 Homebrew 套件

```bash
cd ~/dotfiles
brew bundle --file=./Brewfile
```

這會自動安裝常見 CLI 工具和 GUI app（如 Chrome、Brave 等）。

---

### 第 9 步：安裝開發語言版本（Node.js, Python）

這個 dotfiles 內含 `runtime-setup.sh`，可用來安裝常用語言版本並整合版本控：

```bash
cd ~/dotfiles
./runtime-setup.sh
```

本腳本使用 `asdf` 統一管理多版本語言環境，具備彈性與一致性。

- 安裝 `asdf` 並自動加入 zshrc 初始化
- 安裝下列語言與版本：
  - Node.js：20.11.0（預設）與 18.19.1
  - Python：3.12.1（預設）與 2.7.18
- 自動將 `~/dotfiles/tool-versions` symlink 至 `~/.tool-versions`
- 每個資料夾可以建立 `.tool-versions` 定義要使用的語言版本

---

### 第 10 步：設定 VS Code

```bash
cd ~/dotfiles
./vscode-setup.sh
```

這支腳本會：

- 建立 symlink 至 VS Code 使用者設定
- 安裝 `extensions.txt` 中列出的套件
- （如有）建立 `keybindings.json`

💡 若尚未設定 code CLI，請打開 VS Code 並執行：

`Cmd + Shift + P` → `Shell Command: Install 'code' command in PATH`

---

## 📦 可選項目：Docker + Laravel Sail 開發環境（不需本地安裝 PHP）

### 🐳 安裝 Docker Desktop

```bash
cd ~/dotfiles
./docker-setup.sh
```

> 安裝後請手動開啟 Docker Desktop，等待右上角鯨魚圖示顯示為 Running 狀態。

---

### ⚙️ 建立 Laravel 專案並啟動 Sail

```bash
cd ~/dotfiles
./sail-init.sh my-laravel-app
```

此腳本會：

- 建立 `~/Code/my-laravel-app`
- 使用官方 `laravel.build` 建立 Laravel 專案
- 複製 `.env`
- 建立 alias：`alias sail=./vendor/bin/sail`
- 自動執行 `sail up -d`

完成後可直接使用：

```bash
cd ~/Code/my-laravel-app
sail artisan migrate
```

其他常用指令：

```bash
sail ps
sail down
```

### 📛 Laravel Sail 多專案一鍵關閉工具

如果你同時啟動多個 Laravel Sail 專案，這支小工具可以幫你一次性關閉所有容器：

./sail-down-all.sh

它會自動：

- 掃描 ~/Code 資料夾下所有含有 vendor/bin/sail 的 Laravel 專案
- 判斷是否為可執行的 Sail 專案
- 執行 sail down 關閉容器

✅ 若無任何專案在執行，也會顯示提示，不會報錯

---

## 🧙 一鍵還原新機環境

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/fukuball/dotfiles/master/bootstrap.sh)"
```

---

## 🔧 已包含的設定檔

- `Brewfile`、`gitconfig`、`install.sh`、`zshrc`、`macos.sh`
- `ssh-setup.sh`、`runtime-setup.sh`、`tool-versions`
- `vscode-setup.sh`、`docker-setup.sh`、`sail-init.sh`

---

## 🙌 Author

Fukuball Lin  
GitHub: [https://github.com/fukuball](https://github.com/fukuball)
