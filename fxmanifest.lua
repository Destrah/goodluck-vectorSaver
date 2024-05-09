fx_version 'cerulean'
games { 'gta5' }

author 'Desmond Luck (Destrah)'
description 'Description'
version '1.0.0'

server_scripts {
	"@async/async.lua",
	'config.lua',
	'server/sv_main.lua'
}

client_scripts {
	'config.lua',
	'client/cl_main.lua'
}

dependencies {
	
}
