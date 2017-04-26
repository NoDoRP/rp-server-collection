function LoadUser(source)
	local username = GetPlayerName(source)
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE username = '@name'", {['@name'] = username})
	local result = MySQL:getResults(executed_query, {'username', 'password', 'banned', 'admin', 'money', 'kills', 'deaths', 'personalvehicle', 'pv_price'})
	
	result[1]['isLoggedIn'] = 0
	result[1]['source'] = source
	
	print(GetPlayerName(result[1]['source']))
	print(result[1]['money'])
	

	return result[1]
end

function loginUser(source, password)
	local username = GetPlayerName(source)
	if hasAccount(source) and not isLoggedIn(source) then
		if(Users[GetPlayerName(source)] == nil)then
			Users[GetPlayerName(source)] = LoadUser(source)
		end
		if(password ~= nil) then
			if(VerifyPasswordHash(password, Users[username]['password'])) then 
				Users[username]['isLoggedIn'] = 1
				SendPlayerChatMessage(source, "🔓 You've successfully logged in !")
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {0, 255, 0}, "💡 Hold L-Alt for the player list and type /help for a list of commands.")
				TriggerClientEvent("AwesomeFreeze", source, false)
				TriggerClientEvent("AwesomeInvisible", source, false)
				TriggerClientEvent("AwesomeGod", source, false)
				TriggerClientEvent("teleportSpawning", source)
				TriggerClientEvent("clientPlayerData", source, Users[GetPlayerName(source)]['money'])
				TriggerClientEvent("createTimer", source)
				TriggerClientEvent("clientPaid", source)
			else
				SendPlayerChatMessage(source, "🔒 You entered an invalid password !")
			end
		end
	end
end	