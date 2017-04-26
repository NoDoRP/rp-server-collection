function getDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent("useFunction")
AddEventHandler("useFunction", function(r, g, b)
	if not isLoggedIn(source) then
		return
	end
	
	if(r == 0 and g == 0 and b == 255)then
		local executed_query = MySQL:executeQuery("SELECT * FROM businesses")
		local result = MySQL:getResults(executed_query, {'x', 'y', 'z', 'name', 'owner', 'price', 'income', 'id'})
		local closeBusiness = nil
		
		local plyLocation = Player_Coords[GetPlayerName(source)]
		for i, name in ipairs(result) do
			if(getDistance(toFloat(result[i]['x']),toFloat(result[i]['y']), toFloat(result[i]['z']), tonumber(plyLocation['x']), tonumber(plyLocation['y']), tonumber(plyLocation['z'])) < 4)then
				closeBusiness = result[i]
			end
		end
		
		if(closeBusiness)then
			SendPlayerChatMessage(source, "^2--- ^4🏢"..closeBusiness['name'].." ^2---")
			if(closeBusiness['owner'] ~= "")then
				SendPlayerChatMessage(source, "^3Owner: ^4"..closeBusiness['owner'])
				SendPlayerChatMessage(source, "^3Income: ^2💲"..closeBusiness['income'])
				SendPlayerChatMessage(source, "^3Worth: ^2💲"..closeBusiness['price'])
			else
				SendPlayerChatMessage(source, "^2Owner: ^1NONE ^5(^4Buy with /re buy cost: ^2💲"..closeBusiness['price'].."^5)")
			end
		end
	elseif(r == 0 and g == 0 and b == 0)then
		local executed_query = MySQL:executeQuery("SELECT * FROM robbables")
		local result = MySQL:getResults(executed_query, {'x', 'y', 'z', 'name', 'jackpot', 'id'})		
		
		local closeRobbable = nil
		
		local plyLocation = Player_Coords[GetPlayerName(source)]
		print(plyLocation)
		
		for i, name in ipairs(result) do
			if(getDistance(toFloat(result[i]['x']),toFloat(result[i]['y']), toFloat(result[i]['z']), plyLocation['x'], plyLocation['y'], plyLocation['z']) < 4)then
				closeRobbable = result[i]
			end
		end
		
		if(closeRobbable ~= nil)then
			if(Players_Currently_Robbing[GetPlayerName(source)] == nil)then
				if(Recently_Robbed[closeRobbable['id']] == nil)then
					playerIsRobbing(source, closeRobbable)
				else
					SendPlayerChatMessage(source, "^1This robbable has already been robbed recently.")
				end
			else
				SendPlayerChatMessage(source, "^1You are already robbing a place!")
			end
		end
	end
end)