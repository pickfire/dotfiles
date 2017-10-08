export TZ=Asia/Singapore
export CFLAGS='-O2 -march=native -pipe'
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS='-j5'
export PATH=$HOME/.local/bin:$PATH
export EDITOR=nvim
export SHELL=fish
export PATH="$HOME/.cargo/bin:$PATH"
eval $(dircolors)
command -v firefox-nightly >/dev/null && export BROWSER=firefox-nightly || export BROWSER=firefox

case $- in
	*i*) command -v fortune >/dev/null && fortune; exec fish;;
esac
