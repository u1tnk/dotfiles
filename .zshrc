## Environment variable configuration
#
# gitのブランチ名と変更状況をプロンプトに表示する
autoload -Uz is-at-least
if is-at-least 4.3.10; then
    # バージョン管理システムとの連携を有効にする
    autoload -Uz vcs_info
    autoload -Uz add-zsh-hook

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"
    zstyle ':vcs_info:git:*' unstagedstr "-"
    zstyle ':vcs_info:git:*' formats '@%b%u%c'
    zstyle ':vcs_info:git:*' actionformats '@%b|%a%u%c'

    # VCSの更新時にPROMPTを自動更新する
    function _update_vcs_info_msg() {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
        psvar[2]=$(_git_not_pushed)
    }
    function _git_not_pushed() {
        if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
            head="$(git rev-parse HEAD)"
            for x in $(git rev-parse --remotes)
                do
                if [ "$head" = "$x" ]; then
                    return 0
                fi
            done
            echo "?"
        fi
        return 0
    }
    add-zsh-hook precmd _update_vcs_info_msg
fi
## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
    PROMPT="%{${}%}$(echo @${HOST%%.*}) %B%{${}%}%/#%{${}%}%b "
    PROMPT2="%B%{${}%}%_#%{${}%}%b "
    SPROMPT="%B%{${}%}%r is correct? [n,y,a,e]:%{${}%}%b "
    RPROMPT="%{${fg[green]}%}%1v%2v%{${reset_color}%}"
    ;;
*)
    PROMPT="%{${}%}%/%%%{${}%} "
    PROMPT2="%{${}%}%_%%%{${}%} "
    SPROMPT="%{${}%}%r is correct? [n,y,a,e]:%{${}%} "
    RPROMPT="%{${fg[green]}%}%1v%2v%{${reset_color}%}"
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${}%}$(echo @${HOST%%.*}) ${PROMPT}"
    ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd
setopt pushd_ignore_dups          # 同ディレクトリを履歴に追加しない

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed
setopt list_types                 # 補完一覧ファイル種別表示

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt hist_reduce_blanks         # スペース排除
setopt EXTENDED_HISTORY           # zshの開始終了を記録



#履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## Completion configuration
#
fpath=(${HOME}/dotfiles/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit -u

## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    umask 002
    ;;
esac

alias ll="ls -lah"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias vi="vim"
alias view="vim -R"
alias gvim="/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent"

#tmux
alias ta="tmux attach || tmux new-session \; source-file ~/dotfiles/.tmux.session"

#git shortcuts
alias ci="git commit --interactive"
alias cm="git commit -v"
alias pull="git pull"
alias push="git push"
alias gm="git merge"
alias gl="git hist"
alias gll="git hist --date=iso"
alias gg="git hist --grep"
alias co="git checkout"
alias add="git add"
alias addp="git add -p"
alias gs="git status"
alias gd="git diff"
alias gb="git branch"
alias gsub="git submodule"
alias gt="git tag"
alias gtl="git tag -l -n1"

#rails 
alias r="bundle exec rails"
alias rake="bundle exec rake"
alias be="bundle exec"

## terminal configuration
#

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

## 補完候補がなければより曖昧に候補を探す。
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

## 補完方法毎にグループ化する。
### 補完方法の表示方法
###   %B...%b: 「...」を太字にする。
###   %d: 補完方法のラベル
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

## 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。
###           ただし、補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2

## 補完候補に色を付ける。
### "": 空文字列はデフォルト値を使うという意味。
zstyle ':completion:*:default' list-colors ""

## 補完方法の設定。指定した順番に実行する。
### _oldlist 前回の補完結果を再利用する。
### _complete: 補完する。
### _match: globを展開しないで候補の一覧から補完する。
### _history: ヒストリのコマンドも補完候補とする。(なぜかzshが落ちるので削除)
### _ignored: 補完候補にださないと指定したものも補完候補とする。
### _approximate: 似ている補完候補も補完候補とする。
### _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix _history

## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
## 詳細な情報を使う。
zstyle ':completion:*' verbose yes
## sudo時にはsudo用のパスも使う。
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

## カーソル位置で補完する。
setopt complete_in_word
## globを展開しないで候補の一覧から補完する。
setopt glob_complete
## 補完時にヒストリを自動的に展開する。
setopt hist_expand
## 補完候補がないときなどにビープ音を鳴らさない。
setopt no_beep
## 辞書順ではなく数字順に並べる。
setopt numeric_glob_sort
# set terminal title including current directory

# --prefix=~/localというように「=」の後でも
# 「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst


#補完数が多い時に許可を聞く閾値
LISTMAX=100

# grep 
#
## GNU grepがあったら優先して使う。
if type ggrep > /dev/null 2>&1; then
    alias grep=ggrep
fi
## デフォルトオプションの設定
export GREP_OPTIONS
### バイナリファイルにはマッチさせない。
GREP_OPTIONS="--binary-files=without-match"
### 拡張子が.tmpのファイルは無視する。
GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"
## 管理用ディレクトリを無視する。
if grep --help 2>&1 | grep -q -- --exclude-dir; then
    GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.deps $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.libs $GREP_OPTIONS"
fi
### 可能なら色を付ける。
if grep --help 2>&1 | grep -q -- --color; then
    GREP_OPTIONS="--color=auto $GREP_OPTIONS"
fi
### grep対象としてディレクトリを指定したらディレクトリ内を再帰的にgrepする。
GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"

## ディレクトリが変わったらディレクトリスタックを表示。
chpwd_functions=($chpwd_functions dirs)

## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

## 全てのユーザのログイン・ログアウトを監視する。
watch="all"
## ログイン時にはすぐに表示する。
log

## ^Dでログアウトしないようにする。
setopt ignore_eof

## 完全に削除。
alias rr="command rm -rf"

## ファイル操作を確認する。
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias -g G='| grep -i'

source ${HOME}/dotfiles/zaw/zaw.zsh

zmodload zsh/parameter
_Z_CMD="j"
source $HOME/dotfiles/z/z.sh

function zaw-src-z() {
    # see http://stackoverflow.com/questions/452290/ for IFS trick
    IFS=$(echo -n -e "\0")
    : ${(A)candidates::=$(z \
        | sed -e 's/^[0-9\\. ]*//' -e 's/ /\\ /g' -e "s#^$HOME#~#" \
        | tac | tr '\n' '\0')}
    unset IFS
    actions=("zaw-callback-execute" "zaw-callback-replace-buffer" "zaw-callback-append-to-buffer")
    act_descriptions=("execute" "replace edit buffer" "append to edit buffer")
}

zaw-register-src -n z zaw-src-z

zsh-history() {
  zaw zaw-src-history
}
zle -N zsh-history
bindkey '^h' zsh-history

zsh-z() {
  zaw zaw-src-z
}
zle -N zsh-z
bindkey '^z' zsh-z

case "${TERM}" in
xterm|xterm-color|kterm|kterm-color)
    function precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
       _z --add "$(pwd -P)"
    }
    ;;
*)
    function precmd() {
       _z --add "$(pwd -P)"
    }
    ;;
esac
alias tac="tail -r"

alias rtags='ctags -R --langmap=RUBY:.rb --sort=yes ~/.rvm/rubies/ruby-1.9.3-p194 -f=~/rtags'

alias z="be zeus"

# mosh
compdef mosh=ssh
