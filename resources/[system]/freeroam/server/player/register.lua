-- Loading MySQL Class
require "resources/freeroam/lib/MySQL"

-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("127.0.0.1", "gta5_gamemode_freeroam", "root", "")
local json = require( "json" ) 

function hasAccount(source)
	local username = GetPlayerName(source)
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE username = '@name'", {['@name'] = username})
	local result = MySQL:getResults(executed_query, {'username', 'password', 'banned', 'admin', 'money'}, "username")
		
	if(result[1] ~= nil) then
		return true
	end
	return false
end

function isLoggedIn(source)
	if(Users[GetPlayerName(source)] ~= nil)then
	if(Users[GetPlayerName(source)]['isLoggedIn'] == 1) then
		return true
	else
		return false
	end
	else
		return false
	end
end

function topMoney()
	local executed_query = MySQL:executeQuery("SELECT * FROM users ORDER BY money DESC LIMIT 1")
	local result = MySQL:getResults(executed_query, {'username', 'password', 'banned', 'admin', 'money'})
	
	
	if(result[1] ~= nil)then
		return result[1]
	end
end

function saveMoney(source)
	local username = GetPlayerName(source)
	MySQL:executeQuery("UPDATE users SET money='@newMoney' WHERE username = '@username'",
    {['@username'] = username, ['@newMoney'] = Users[username]['money']})
	
	TriggerClientEvent("clientPlayerData", source, Users[username]['money'])
end

function saveKD(source)
	local username = GetPlayerName(source)
	MySQL:executeQuery("UPDATE users SET kills='@newKD' WHERE username = '@username'",
    {['@username'] = username, ['@newKD'] = Users[username]['kills']})
	
	MySQL:executeQuery("UPDATE users SET deaths='@newKD' WHERE username = '@username'",
    {['@username'] = username, ['@newKD'] = Users[username]['deaths']})
end

function savePersonalVehicle(source)
	local username = GetPlayerName(source)
	MySQL:executeQuery("UPDATE users SET personalvehicle='@newPersonalvehicle', pv_price='@pvPrice' WHERE username = '@username'",
    {['@username'] = username, ['@newPersonalvehicle'] = Users[username]['personalvehicle'], ['@pvPrice'] = Users[username]['pv_price']})
end

function registerUser(source, password)
	if not hasAccount(source) then
		local username = GetPlayerName(source)
		-- Inserting Default User Account Stats
		MySQL:executeQuery("INSERT INTO users (`username`, `password`, `banned`, `admin`, `money`) VALUES ('@username', '@password', '0', '0', '10')",
		{['@username'] = username, ['@password'] = GetPasswordHash(password)})
		
		Users[username] = LoadUser(source)
		
		Users[username]['isLoggedIn'] = 1
		Users[username]['source'] = source
		
		SendPlayerChatMessage(source, "You were succesfully registered!")
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {0, 255, 0}, "💡 Hold X for the player list and type /help for a list of commands.")
		TriggerClientEvent("AwesomeFreeze", source, false)
		TriggerClientEvent("AwesomeInvisible", source, false)
		TriggerClientEvent("teleportSpawning", source)
		TriggerClientEvent("clientPaid", source)
		TriggerClientEvent("clientPlayerData", source, Users[username]['money'])
		TriggerClientEvent("createTimer", source)
	end
end