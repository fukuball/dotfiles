# -----------------------------
# Oh My Zsh 基礎設定
# -----------------------------
export ZSH="$HOME/.oh-my-zsh"          # 指定 Oh My Zsh 安裝位置
ZSH_THEME="robbyrussell"               # 使用內建穩定主題
plugins=(git)                          # 啟用最基礎的 plugin（也支援補全與 branch 顯示）

# -----------------------------
# Shell 行為設定
# -----------------------------
setopt HIST_IGNORE_DUPS                # 忽略重複的歷史指令
setopt INC_APPEND_HISTORY              # 即時寫入歷史

# -----------------------------
# 載入 Oh My Zsh 核心
# -----------------------------
source $ZSH/oh-my-zsh.sh

# -----------------------------
# 環境變數設定
# -----------------------------
export PATH="/opt/homebrew/bin:$PATH"  # 加入 Homebrew 套件路徑（Apple Silicon 路徑）
export EDITOR=nvim                     # 設定預設編輯器為 neovim

# -----------------------------
# 初始化 asdf
# -----------------------------
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# -----------------------------
# alias
# -----------------------------
alias sail="./vendor/bin/sail"
