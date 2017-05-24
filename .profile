export TZ=Asia/Singapore
export CFLAGS='-O2 -march=native -pipe'
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS='-j5'
export PATH=$HOME/.local/bin:$PATH
export EDITOR=kak
export BROWSER=firefox
export SHELL=fish
case $- in
	*i*) command -v fortune >/dev/null && fortune; exec fish;;
esac
