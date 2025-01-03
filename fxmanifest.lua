fx_version 'cerulean'
game 'gta5'
author 'catherina'
description 'Dimension Zone System and Sound in Zone' 
version '0.1'

client_scripts {
	'config.lua',
	'client/cl_main.lua',
	
}
server_scripts {
	'config.lua',
	'server/sv_main.lua',
}

files {
    'html/index.html',
    'html/sounds/*.mp3'
}

ui_page 'html/index.html'