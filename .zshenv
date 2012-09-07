# LANG
#
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8  
case ${UID} in
0)
    LANG=C
    ;;
esac

#emacsキーバインド
bindkey -e

## 重複したパスを登録しない。
typeset -U path
## (N-/): 存在しないディレクトリは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            /: ディレクトリのみ残す。
path=(# システム用
      /bin(N-/)
      # 自分用
      $HOME/local/bin(N-/)
      $HOME/local/rsense/bin(N-/)
      $HOME/scripts(N-/)
      $HOME/.rvm/bin(N-/)
      $HOME/.cabal/bin(N-/)
      /Applications/Day\ One.app/Contents/MacOS/(N-/)
      # システム用
      /usr/local/bin(N-/)
      /sbin(N-/)
      /usr/sbin(N-/)
      /usr/bin(N-/))

fpath=(
      $fpath
      $HOME/dotfiles/fpath(N-))


## 重複したパスを登録しない。
typeset -U manpath
## (N-/) 存在しないディレクトリは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            /: ディレクトリのみ残す。
manpath=(# 自分用
         $HOME/local/share/man(N-/)
         # システム用
         /usr/local/share/man(N-/)
         /usr/share/man(N-/))

## -x: export SUDO_PATHも一緒に行う。
## -T: SUDO_PATHとsudo_pathを連動する。
typeset -xT SUDO_PATH sudo_path
## 重複したパスを登録しない。
typeset -U sudo_path
## (N-/): 存在しないディレクトリは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            /: ディレクトリのみ残す。
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

#pager
if type lv > /dev/null 2>&1; then
    ## lvを優先する。
    export PAGER="lv"
else
    ## lvがなかったらlessを使う。
    export PAGER="less"
fi

## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
## -l: 1行が長くと折り返されていても1行として扱う。
##     （コピーしたときに余計な改行を入れない。）
if [ "$PAGER" = "lv" ]; then
    ## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
    ## -l: 1行が長くと折り返されていても1行として扱う。
    ##     （コピーしたときに余計な改行を入れない。）
    export LV="-c -l"
else
    ## lvがなくてもlvでページャーを起動する。
    alias lv="$PAGER"
fi

case "${OSTYPE}" in
darwin*)
    export EDITOR=/usr/bin/vim
    export LD_LIBRARY_PATH=/usr/local/lib
    export CC=gcc-4.2
    ;;
linux*)
    export EDITOR=vim
    ;;
esac

## ~/.zsh.d/email → ~/.emailの順に探して最初に見つかったファイルから読み込む。
## (N-.): 存在しないファイルは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            .: 通常のファイルのみ残す。
email_files=(~/.email(N-.)
             ~/dotfiles/.email(N-.))
for email_file in ${email_files}; do
    export EMAIL=$(cat "$email_file")
    break
done

export GISTY_DIR=$HOME/Dropbox/snippets/gists

#ruby rvm有効化
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

