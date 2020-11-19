export TZ=Asia/Singapore
export CFLAGS='-O2 -march=native -pipe'
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS=-j$(expr $(nproc) + 1)
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/src/go/bin:$PATH"
export LESS=-RS
export EDITOR=kak
export GOPATH="$HOME/src/go"
export JAVA_HOME=/usr/lib/jvm/default/

command -v gem >/dev/null && export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH" GEM_HOME=$HOME/.gem
command -v firefox-developer-edition >/dev/null && export BROWSER=firefox-developer-edition || export BROWSER=firefox
test -f /usr/share/LS_COLORS/dircolors.sh && . /usr/share/LS_COLORS/dircolors.sh
test -e ~/.nix-profile/etc/profile.d/nix.sh && . ~/.nix-profile/etc/profile.d/nix.sh

# if command -v rustc >/dev/null
# then
#   # sccache integration degrade with incremental compilation
#   if command -v sccache >/dev/null
#   then
#     export RUSTC_WRAPPER="sccache"
#   fi
# fi

alias tm='tmux -u attach'
alias home='git --work-tree=/home/ivan --git-dir=/home/ivan/.home'

# arcticicestudio/igloo
export GRADLE_OPTS="-Dorg.gradle.daemon=true -Dorg.gradle.console=rich"

# using fish as interactive shell
if command -v fish >/dev/null
then
  export SHELL=fish
  case $- in
    *i*) command -v fortune >/dev/null && fortune; exec $SHELL;;
  esac
fi
