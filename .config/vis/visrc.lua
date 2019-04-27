-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/complete-word')
require('plugins/filetype')
require('plugins/textobject-lexer')

vis:operator_new("gq", function(file, range, pos)
	local status, out, err = vis:pipe(file, range, "fmt")
	if not status then
		vis:info(err)
	else
		file:delete(range)
		file:insert(range.start, out)
	end
	return range.start -- new cursor location
end, "Formating operator, filter range through fmt(1)")

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('set theme dark-16')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	-- vis:command('set number')
	vis:command('set autoindent')
	vis:command('set colorcolumn 80')
end)
