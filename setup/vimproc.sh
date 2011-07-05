#/bin/sh
rm ~/.vim/bundle/vimproc/autoload/proc.so
cd ~/.vim/bundle/vimproc

case $OSTYPE in
darwin*)
    make -f make_mac.mak
    ;;
*)
    make -f make_gcc.mak
    ;;
esac

