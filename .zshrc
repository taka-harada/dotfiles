#プロファイル表示
#zmodload zsh/zprof

# 環境変数
export LANG=ja_JP.UTF-8

# ------------------------------
#    補完
# ------------------------------
# 遅いので一旦コメントアウト
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

## 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## 日本語ファイルを扱えるようにする
setopt print_eight_bit

# ------------------------------
#   コマンド履歴の管理
# ------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000

##  直前の重複を記録しない
setopt hist_ignore_dups


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ------------------------------
#    zinit
# ------------------------------
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

### Added by Zplugin's installer
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
source ~/powerlevel10k/powerlevel10k.zsh-theme

## コマンドに色付け
zinit ice wait'!0'; zinit load zsh-users/zsh-syntax-highlighting

## プロンプトテーマをpowerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# ------------------------------
#    path
# ------------------------------

# anyenv init - を実行する処理
eval "$(anyenv init -)"
eval "$(nodenv init -)"

if [ -x /usr/local/bin/anyenv ]
then
   if ! [ -f /tmp/anyenv.cache ]
   then
      anyenv init - --no-rehash > /tmp/anyenv.cache
      zcompile /tmp/anyenv.cache
   fi
   source /tmp/anyenv.cache

   if ! [ -f /tmp/nodenv.cache ]
   then
      nodenv init - > /tmp/nodenv.cache
      zcompile /tmp/nodenv.cache
   fi
   source /tmp/nodenv.cache

   if ! [ -f /tmp/phpenv.cache ]
   then
     phpenv init - --no-rehash > /tmp/phpenv.cache
     zcompile /tmp/phpenv.cache
   fi
   source /tmp/phpenv.cache
fi

# phpenvが遅いので呼び出された時に初期化コードが走るようにする
#phpenv() {
#  unfunction "$0"
#  source <(phpenv init -)
#  $0 "$@"
#}
#eval "$(phpenv init -)"

export PATH="/usr/local/opt/bison@2.7/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/bzip2/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/opt/krb5/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/zlib/bin:$PATH"
#export DYLD_LIBRARY_PATH="/usr/lib/libSystem.B.dylib"
#export DYLD_LIBRARY_PATH=/path/to/lib:$DYLD_LIBRARY_PATH

# direnv
eval "$(direnv hook zsh)"

# PKG_CONFIG_PATH を設定
export PKG_CONFIG_PATH="/usr/local/opt/krb5/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

#zprof

# bun completions
[ -s "/Users/taka/.bun/_bun" ] && source "/Users/taka/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
