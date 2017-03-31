# abbrs.fish based on @faho

if not set -q fish_initialized
	abbr -a fish_uninitialized set -e fish_user_abbreviations\; set -e fish_initialized

	abbr -a sx	exec sx
	abbr -a gdb	gdb -q

	abbr -a pacman	sudo pacman

	set -U TZ	Asia/Singapore
	set -U CFLAGS	'-O2 -march=native -pipe'
	set -U CXXFLAGS	$CFLAGS
	set -U MAKEFLAGS -j5

	set -U fish_user_paths ~/.local/bin $PATH
	set -U TIMEWARRIORDB ~/.task/timew

	set -U fish_initialized
end
