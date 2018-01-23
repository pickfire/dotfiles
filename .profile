export TZ=Asia/Singapore
export CFLAGS='-O2 -march=native -pipe'
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS='-j5'
export PATH=$HOME/.local/bin:$PATH
export EDITOR=vi
export PATH="$HOME/.cargo/bin:$PATH"

command -v gem >/dev/null && export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH" GEM_HOME=$HOME/.gem
command -v dircolors >/dev/null && eval $(dircolors)
command -v firefox-nightly >/dev/null && export BROWSER=firefox-nightly || export BROWSER=firefox

if command -v fish >/dev/null
then
  export SHELL=`which fish`
  case $- in
    *i*) command -v fortune >/dev/null && fortune; exec $SHELL;;
  esac
fi

alias tm='tmux -u attach'

# arcticicestudio/igloo
export GRADLE_OPTS="-Dorg.gradle.daemon=true -Dorg.gradle.console=rich"
