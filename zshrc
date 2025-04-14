export ZSH="$HOME/.oh-my-zsh"          # 指定 Oh My Zsh 安裝位置
ZSH_THEME="robbyrussell"               # 使用內建穩定主題
plugins=(git)                          # 啟用最基礎的 plugin（也支援補全與 branch 顯示）

setopt HIST_IGNORE_DUPS                # 忽略重複的歷史指令
setopt INC_APPEND_HISTORY              # 即時寫入歷史

source $ZSH/oh-my-zsh.sh               # 載入 Oh My Zsh 核心

export PATH="/opt/homebrew/bin:$PATH"  # 加入 Homebrew 套件路徑（Apple Silicon 路徑）
export EDITOR=nvim                     # 設定預設編輯器為 neovim
