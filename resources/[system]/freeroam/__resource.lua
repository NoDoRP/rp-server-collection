description 'Gamemode from Kanersps.'

ui_page 'ui.html'

files {
	'ui.html',
	'pdown.ttf'
}

-- Global
client_script 'client.lua'
server_script 'server.lua'

-- Client
client_script 'client/main.lua'
client_script 'client/player/pvp.lua'
client_script 'client/player/messaging.lua'
client_script 'client/player/teleportation.lua'
client_script 'client/player/register.lua'
client_script 'client/player/native.lua'
client_script 'client/player/customizer.lua'
client_script 'client/gui/playerheads.lua'
client_script 'client/gui/playerlist.lua'
client_script 'client/gui/main_gui.lua'
client_script 'client/business.lua'
client_script 'client/crew.lua'
client_script 'client/jobs/heists.lua'
client_script 'client/vehshop.lua'

-- Server
server_script 'server/main.lua'
server_script 'server/jobs.lua'
server_script 'server/player/ban.lua'
server_script 'server/player/kick.lua'
server_script 'server/player/admin.lua'
server_script 'server/player/register.lua'
server_script 'server/player/login.lua'
server_script 'server/business.lua'
server_script 'server/crew.lua'
server_script 'server/jobs/heists.lua'
server_script 'server/vehshop.lua'