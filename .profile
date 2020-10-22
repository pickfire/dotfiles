export TZ=Asia/Singapore
export CFLAGS='-O2 -march=native -pipe'
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS='-j5'
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=kak
export PATH="$HOME/.cargo/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/default/

command -v gem >/dev/null && export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH" GEM_HOME=$HOME/.gem
command -v firefox-developer-edition >/dev/null && export BROWSER=firefox-developer-edition || export BROWSER=firefox
. /usr/share/LS_COLORS/dircolors.sh

if command -v rustc >/dev/null
then
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
  # sccache integration degrade with incremental compilation
  # if command -v sccache >/dev/null
  # then
  #   export RUSTC_WRAPPER="sccache"
  # fi
fi

alias tm='tmux -u attach'
alias home='git --work-tree=/home/ivan --git-dir=/home/ivan/.home'

# arcticicestudio/igloo
export GRADLE_OPTS="-Dorg.gradle.daemon=true -Dorg.gradle.console=rich"

if command -v go >/dev/null
then
  export PATH="$HOME/src/go/bin:$PATH"
fi

if [ -e /home/ivan/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ivan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
if command -v fish >/dev/null
then
  export SHELL=fish
  case $- in
    *i*) command -v fortune >/dev/null && fortune; exec $SHELL;;
  esac
fi
