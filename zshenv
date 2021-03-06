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
      $HOME/.local/bin(N-/)
      $HOME/go/bin(N-/)
      $HOME/local/rsense/bin(N-/)
      $HOME/scripts(N-/)
      $HOME/.rbenv/bin(N-/)
      $HOME/.cabal/bin(N-/)
      $HOME/.nodebrew/current/bin(N-/)
      $HOME/node_modules/.bin(N-/)
      $HOME/.embulk/bin
      $HOME/.nodenv/bin
      $HOME/.composer/vendor/bin
      $HOME/go/bin
      $HOME/.tfenv/bin
      # システム用
      /snap/bin
      /opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
      /usr/local/mysql/bin(N-/)
      /usr/local/bin(N-/)
      /usr/local/sbin(N-/)
      /sbin(N-/)
      /usr/sbin(N-/)
      /usr/bin(N-/)
      "/mnt/c/Program Files/Docker/Docker/resources/bin"
      "/mnt/c/ProgramData/DockerDesktop/version-bin"
)

fpath=(
      $fpath
      $HOME/dotfiles/fpath(N-)
      $HOME/.zsh/functions/Completion(N-)
      )

if [[ "${OSTYPE}" =~ darwin.* ]]; then
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

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

export GOPATH=~/go

eval "$(rbenv init --no-rehash -)"

