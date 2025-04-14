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
eval "$(/opt/homebrew/bin/brew shellenv)"
```

確認 brew 可用：

```bash
brew doctor
```

---

### 第 2 步：Clone 這個 dotfiles 專案

```bash
git clone git@github.com:your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

> 如果你沒用 SSH，可以改成：
> `git clone https://github.com/your-username/dotfiles.git ~/dotfiles`

---

### 第 3 步：執行安裝腳本

```bash
./install.sh
```

這會建立 symlink 到 `.zshrc`、`.gitconfig` 等設定檔。

---

### 第 4 步：安裝所有 Homebrew 套件

```bash
brew bundle --file=~/dotfiles/Brewfile
```

這會自動安裝我常用的 CLI 工具和 GUI app（如 Chrome、Brave 等）。

---

## ⚙️ 安裝 Oh My Zsh（包含 zshrc 設定）

這個 dotfiles 假設你會使用 [Oh My Zsh](https://ohmyz.sh/)，並搭配內建的 robbyrussell 主題。

### 第一步：安裝 Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 第二步：還原 dotfiles 的 zsh 設定

```bash
ln -sf ~/dotfiles/zshrc ~/.zshrc
source ~/.zshrc
```

### 預設的 zshrc 設定內容如下：

```zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH="/opt/homebrew/bin:$PATH"
export EDITOR=nvim

setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
```

這份設定會提供乾淨、穩定的 zsh 體驗，並搭配 Git plugin 顯示當前 branch。

---

## 🔧 已包含的設定檔

- `zshrc`：Shell 設定
- `gitconfig`：Git 使用者與格式設定
- `Brewfile`：所有使用 Homebrew 安裝的工具清單
- `install.sh`：建立 symlink 的自動化腳本
- `macos.sh`：macOS 系統偏好設定自動化腳本

---

## 📦 已安裝的套件清單（部份）

透過 `brew bundle` 安裝這些工具：

- CLI 工具：`git`, `gh`, `zsh`, `fzf`, `htop`, `neovim`
- GUI 工具：`google-chrome`, `brave-browser`

---

## 🚀 待辦（可選擇性擴充）

- 加入 VS Code 設定
- 加入 Node.js / Python 開發環境（如 `asdf` / `pyenv`）
- 加入 SSH Key / GitHub 設定腳本
- 加入 macOS 系統偏好設定腳本

---

## 🙌 Author

Fukuball Lin  
GitHub: [https://github.com/your-username](https://github.com/your-username)
