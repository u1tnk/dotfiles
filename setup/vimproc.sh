#/bin/sh
rm ~/.bundle/vimproc/autoload/proc.so
cd ~/.bundle/vimproc

case $OSTYPE in
darwin*)
    make -f make_mac.mak
    ;;
*)
    make -f make_unix.mak
    ;;
esac

