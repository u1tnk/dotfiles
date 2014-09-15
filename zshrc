#履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

case "${OSTYPE}" in
darwin*)
    alias ls="ls -G -w"
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
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

#tmux

# reattach-to-user-namespaceをmac/linux判定を.tmux.confでやろうとしたが難しかったので
# http://yuroyoro.hatenablog.com/entry/20120211/1328930819
# で紹介されていた
# https://github.com/isseium/tmuxx
# を$PATHにtmuxxで登録してみたけど、初期で分割するsessionファイルを指定したかったので改変した
# .zshrcだけで管理した方がシンプルだし
function tn(){
    if [[ ( $OSTYPE == darwin* ) && ( -x $(which reattach-to-user-namespace 2>/dev/null) ) ]]; then
        # on OS X force tmux's default command to spawn a shell in the user's namespace
        # https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
        tweaked_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))

        tmux -f <(echo "$tweaked_config") new-session \; source-file ~/dotfiles/.tmux.session
    else
        tmux new-session \; source-file ~/dotfiles/.tmux.session
    fi
}
function ta(){
  tmux attach || tn
}

# alias tmux="tmuxx"
# alias ta="tmuxx attach || tmuxx new-session \; source-file ~/dotfiles/.tmux.session"

#git shortcuts
alias ga="git add --patch"
alias gs="git status --short"
alias gst="git stash"
alias gl="git log --pretty=format:\"%C(green)%h %C(blue)%ad %C(red)|%C(reset) %s%d [%an]\" --graph --date=short"

# ruby
alias b="bundle exec"

## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

## ^Dでログアウトしないようにする。
setopt ignore_eof

## ファイル操作を確認する。
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias -g G='| grep -i'

alias tac="tail -r"

alias rt="RAILS_ENV=test"
alias dbreset="bin/rake db:migrate:reset && bin/rake db:seed_fu && RAILS_ENV=test bin/rake db:migrate:reset"

if test -e /usr/local/share/python/virtualenvwrapper.sh; then
    source /usr/local/share/python/virtualenvwrapper.sh
fi

export PATH=$PATH:/usr/local/share/python

export AWS_DEFAULT_REGION=ap-northeast-1

if [[ "${OSTYPE}" == darwin.* ]]; then
    # http://qiita.com/kei_s/items/96ee6929013f587b5878
    source ~/dotfiles/zsh-notify/notify.plugin.zsh
    export NOTIFY_COMMAND_COMPLETE_TIMEOUT=30
fi

eval "$(rbenv init -)"

AWS_CLI_COMPLETER_PATH=/usr/local/share/python/aws_zsh_completer.sh
if test -e $AWS_CLI_COMPLETER_PATH; then
    source $AWS_CLI_COMPLETER_PATH
fi

# zshenvでやってたらprezto化後nanoに変わるようになったのでここで設定
export EDITOR=vim

# pecoで履歴検索
# http://blog.kenjiskywalker.org/blog/2014/06/12/peco/
# tacはこのファイルで別途定義してるので削除した
function peco-select-history() {
    BUFFER=$(history -n 1 | \
        eval tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-select-apps() {
    eval cd ~/apps/$(ffind -d ~/apps --depth 1 --type d | peco)
    zle clear-screen
}
zle -N peco-select-apps
bindkey "^@^a" peco-select-apps
