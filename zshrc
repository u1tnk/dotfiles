#履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


case "${OSTYPE}" in
darwin*)
    alias ls="ls -G -w"
#     alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vim='nvim'
    alias tac="tail -r"
    ;;
linux*)
    alias ls="ls --color"
    alias vim='nvim'
    EDITOR='nvim'
    umask 002
    setterm -blength 0
    ;;
esac

alias ll="ls -lah"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias vi="vim"
alias view="vim -R"

alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"

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
        tmux -2 new-session \; source-file ~/dotfiles/.tmux.session
    fi
}
function ta(){
  tmux -2 attach || tn
}
export TMUX_TMPDIR=/tmp

# alias tmux="tmuxx"
# alias ta="tmuxx attach || tmuxx new-session \; source-file ~/dotfiles/.tmux.session"

#git shortcuts
alias ga="git add --patch"
alias gs="git status --short"
alias gst="git stash"
alias gl="git log --pretty=format:\"%C(green)%h %C(blue)%ad %C(red)|%C(reset) %s%d [%an]\" --graph --date=short"

# ruby
alias be="bundle exec"
alias rs="bundle exec spring rails s --port=3000 --binding=0.0.0.0"
alias rsp="bundle exec spring rspec"
alias r="bundle exec spring rails"
alias ra="bundle exec spring rake"
alias ss="bundle exec spring stop"

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

alias rt="RAILS_ENV=test"
alias dbreset="bin/rake db:migrate:reset && bin/rake db:seed_fu"

# if test -e /usr/local/share/python/virtualenvwrapper.sh; then
#     source /usr/local/share/python/virtualenvwrapper.sh
# fi

export PATH=$PATH:/usr/local/share/python

export AWS_DEFAULT_REGION=ap-northeast-1

if [[ "${OSTYPE}" == darwin.* ]]; then
    # http://qiita.com/kei_s/items/96ee6929013f587b5878
    source ~/dotfiles/zsh-notify/notify.plugin.zsh
    export NOTIFY_COMMAND_COMPLETE_TIMEOUT=30
fi


AWS_CLI_COMPLETER_PATH=/usr/local/share/python/aws_zsh_completer.sh
if test -e $AWS_CLI_COMPLETER_PATH; then
    source $AWS_CLI_COMPLETER_PATH
fi

# zshenvでやってたらprezto化後nanoに変わるようになったのでここで設定
export EDITOR=vim
export VISUAL=vim
export XDG_CONFIG_HOME=$HOME/dotfiles

# pecoで履歴検索
# http://blog.kenjiskywalker.org/blog/2014/06/12/peco/
# tacはこのファイルで別途定義してるので削除した
# clear-screenがある状態でalias使うと warningが出るので削除

function peco-select-history() {
    BUFFER=$(history -n 1 | \
        eval tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
}
zle -N peco-select-history

bindkey '^r' peco-select-history
alias h=peco-select-history

function peco-select-apps() {
    eval cd $(find $HOME/apps -mindepth 1 -maxdepth 2 -type d | peco)
}
zle -N peco-select-apps
alias j='peco-select-apps'

eval "$(direnv hook zsh)"

eval "$(rbenv init --no-rehash -)"

eval "$(nodenv init -)"

eval "$(pyenv init -)"

alias drubo="git diff  --name-only --diff-filter=AM | grep '.rb$' | xargs bundle exec rubocop -RDa"

alias tenki='curl wttr.in/yokohama\?lang=ja'

# ssh_agent起動の自動化
SSH_AGENT_FILE=$HOME/.ssh-agent
test -f $SSH_AGENT_FILE && source $SSH_AGENT_FILE
if ! ssh-add -l > /dev/null 2>&1; then
  rm -f $SSH_AGENT_FILE
  ssh-agent > $SSH_AGENT_FILE
  source $SSH_AGENT_FILE
  ssh-add $HOME/.ssh/id
fi
