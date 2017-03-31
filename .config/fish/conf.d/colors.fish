# Default fish colors with minor contrast change
if not set -q _fish_colors_set
	set -U fish_color_normal normal
	set -U fish_color_command 005fd7 purple
	set -U fish_color_param 00afff cyan
	set -U fish_color_redirection normal
	set -U fish_color_comment red
	set -U fish_color_error red --bold
	set -U fish_color_escape cyan
	set -U fish_color_operator cyan
	set -U fish_color_end brmagenta
	set -U fish_color_quote brown
	set -U fish_color_autosuggestion 555 yellow
	set -U fish_color_valid_path --underline

	# Prompt colors
	set -U fish_color_user brgreen
	set -U fish_color_host normal
	set -U fish_color_cwd green
	set -U fish_color_cwd_root red

	# Background color for matching quotes and parenthesis
	set -U fish_color_match cyan

	# Background color for search matches
	set -U fish_color_search_match --background=purple

	# Pager colors
	set -U fish_pager_color_prefix cyan
	set -U fish_pager_color_completion normal
	set -U fish_pager_color_description 777 yellow
	set -U fish_pager_color_progress cyan

	#
	# Directory history colors
	#
	set -U fish_color_history_current cyan

	set -U _fish_colors_set
end
