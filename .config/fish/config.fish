#
# Fish configuration
#
if test -f ~/.dircolors
	eval (dircolors -c ~/.dircolors)
end

alias home="git --work-tree=$HOME --git-dir=$HOME/.home"
