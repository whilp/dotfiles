-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/complete-filename')
require('plugins/complete-word')
require('plugins/filetype')
require('plugins/textobject-lexer')


vis.events.subscribe(vis.events.INIT, function()
	vis:command('set theme solarized')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command('set number')
	vis:command('set autoindent')
	vis:command('set colorcolumn 80')
	vis:command('set show-tabs')
	vis:command('set horizon 128')
end)

