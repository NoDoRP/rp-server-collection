-- Loading MySQL Class
require "resources/freeroam/lib/MySQL"

Player_Coords = {}

RegisterServerEvent("print")
AddEventHandler("print", function(t)
	print(t)
end)

function toFloat(n)
	return string.gsub(tostring(n), ",", ".")
end


RegisterServerEvent("playerCoordsBus")
RegisterServerEvent("requestFullCompanyIncome")
RegisterServerEvent("requestFullCompanyNames")
AddEventHandler("playerCoordsBus", function(xe,ye,ze)
	
	if(Player_Coords[GetPlayerName(source)] == nil)then
		SetTimeout(2000, function()
			local executed_query = MySQL:executeQuery("SELECT * FROM businesses")
			local result = MySQL:getResults(executed_query, {'x', 'y', 'z', 'name'})
			
			for i, name in ipairs(result) do
				TriggerClientEvent("addMarker", source, toFloat(result[i]['x']), toFloat(result[i]['y']), toFloat(result[i]['z']), 0, 0, 255)
			end
			
			executed_query = MySQL:executeQuery("SELECT * FROM robbables")
			result = MySQL:getResults(executed_query, {'x', 'y', 'z', 'name'})
			
			for i, name in ipairs(result) do
				TriggerClientEvent("addMarker", source, toFloat(result[i]['x']), toFloat(result[i]['y']), toFloat(result[i]['z']), 0, 0, 0)
			end
		end)
	end
	Player_Coords[GetPlayerName(source)] = {x = xe, y = ye, z = ze}
end)

AddEventHandler("requestFullCompanyIncome", function()
	local executed_query = MySQL:executeQuery("SELECT * FROM businesses")
	local result = MySQL:getResults(executed_query, {'income', 'owner'})
	local income = 0
	
	for i,name in ipairs(result)do
		if(result[i]['owner'] == GetPlayerName(source))then
			
			income = income + result[i]['income']
		end
	end
	TriggerClientEvent("fullCompanyIncome", source, income)
end)

AddEventHandler("requestFullCompanyNames", function()
	local executed_query = MySQL:executeQuery("SELECT * FROM businesses")
	local result = MySQL:getResults(executed_query, {'name', 'owner'})
	local names = ""
	local owned = 0
	
	for i,name in ipairs(result)do
		if(result[i]['owner'] == GetPlayerName(source))then
			owned = owned + 1
		end
	end
	
	TriggerClientEvent("chatMessage", source, '', {0,0,0}, "^4--- You Own: "..owned.." ---")
	
	for i,name in ipairs(result)do
		if(result[i]['owner'] == GetPlayerName(source))then
			if(i % 3 ~= 0)then		
				names = names .. "" .. result[i]['name'] .. "^4,^2"	
			else
				names = names .. "^0<br/>" .. result[i]['name'] .. "^4,^2"		
			end
		end
	end
	
	TriggerClientEvent("chatMessage", source, '', {0,0,0}, ""..names)
end)

function getDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

AddEventHandler('playerDropped', function(reason)
	Player_Coords[GetPlayerName(source)] = nil
end)

-- Payments each half hour.
function payPeopleCompaniesCEO()
	SetTimeout(1200000, function()
		local executed_query1 = MySQL:executeQuery("SELECT * FROM businesses")
		local executed_query2 = MySQL:executeQuery("SELECT * FROM users")
		local businesses = MySQL:getResults(executed_query1, {'owner', 'income'})
		local users = MySQL:getResults(executed_query2, {'username', 'money'})
		
		for i, name in ipairs(businesses) do
			if(businesses[i]['owner'] ~= "")then
				for j, name in ipairs(users) do
					if(businesses[i]['owner'] == users[j]['username'])then
						users[j]['money'] = users[j]['money'] + businesses[i]['income']
						MySQL:executeQuery("UPDATE users SET money='@newMoney' WHERE username = '@name'",
						{['@newMoney'] = users[j]['money'], ['@name'] = users[j]['username']})
						
						if(Users[users[j]['username']] ~= nil)then
							TriggerClientEvent("clientPlayerData", GetPlayerID(users[j]['username']), users[j]['money'])
							Users[users[j]['username']]['money'] = users[j]['money']
						end
					end
				end
			end
		end
		
		payPeopleCompaniesCEO()
	end)
end
payPeopleCompaniesCEO()

function businessChatCommands(source, command)
	if(command[1] == "/re")then
		local executed_query = MySQL:executeQuery("SELECT * FROM businesses")
		local result = MySQL:getResults(executed_query, {'x', 'y', 'z', 'name', 'owner', 'price', 'income', 'id'})
		local closeBusiness = nil
		
		local plyLocation = Player_Coords[GetPlayerName(source)]
		for i, name in ipairs(result) do
			if(getDistance(toFloat(result[i]['x']),toFloat(result[i]['y']), toFloat(result[i]['z']), tonumber(plyLocation['x']), tonumber(plyLocation['y']), tonumber(plyLocation['z'])) < 4)then
				closeBusiness = result[i]
			end
		end
		
		if(command[2] == nil)then
			if(closeBusiness == nil)then
				SendPlayerChatMessage(source, "^1There is no real estate at this location.")
			else
				SendPlayerChatMessage(source, "^2--- ^4🏢"..closeBusiness['name'].." ^2---")
				if(closeBusiness['owner'] ~= "")then
					SendPlayerChatMessage(source, "^3Owner: ^4"..closeBusiness['owner'])
					SendPlayerChatMessage(source, "^3Income: ^2💲"..closeBusiness['income'])
					SendPlayerChatMessage(source, "^3Worth: ^2💲"..closeBusiness['price'])
				else
					SendPlayerChatMessage(source, "^2Owner: ^1NONE ^5(^4Buy with /re buy cost: ^2💲"..closeBusiness['price'].."^5)")
				end
			end
		elseif(command[2] == "buy")then
			if(closeBusiness == nil)then
				SendPlayerChatMessage(source, "^1There is no real estate at this location.")
			else
				if(closeBusiness['owner'] ~= "")then
					SendPlayerChatMessage(source, "^1This property is already sold!")
				else
					if(Users[GetPlayerName(source)]['money'] >= closeBusiness['price'])then
						SendPlayerChatMessage(source, "^1You just purschased: ^4"..closeBusiness['name'].."^1!")
						Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] - closeBusiness['price']
						saveMoney(source)
						MySQL:executeQuery("UPDATE businesses SET owner='@username' WHERE name = '@name' AND id='@eid'",
						{['@username'] = GetPlayerName(source), ['@name'] = closeBusiness['name'],['@eid'] = closeBusiness['id']})
					end
				end
			end
		elseif(command[2] == "upgrade")then
			if(closeBusiness == nil)then
				SendPlayerChatMessage(source, "^1There is no real estate at this location.")
			else
				if(closeBusiness['owner'] == GetPlayerName(source))then
					local upgradePrice = math.ceil(closeBusiness['price']*1.7)
					local newBuildingPrice = closeBusiness['price'] + upgradePrice
					local newIncome = math.floor(closeBusiness['income']*1.40)
					
					if(Users[GetPlayerName(source)]['money'] >= upgradePrice)then
						MySQL:executeQuery("UPDATE businesses SET price='@newPrice' WHERE name = '@name'",
						{['@newPrice'] = newBuildingPrice, ['@name'] = closeBusiness['name']})
						MySQL:executeQuery("UPDATE businesses SET income='@newIncome' WHERE name = '@name'",
						{['@newIncome'] = newIncome, ['@name'] = closeBusiness['name']})
						Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] - upgradePrice
						saveMoney(source)
						SendPlayerChatMessage(source, "^2Succesfully upgraded property!")
					else
						SendPlayerChatMessage(source, "^1You do not have enough money to upgrade. You need: ^2💲"..upgradePrice)
					end
				else
					SendPlayerChatMessage(source, "^1You do not own this property!")
				end
			end
		elseif(command[2] == "overtake")then
			if(closeBusiness == nil)then
				SendPlayerChatMessage(source, "^1There is no real estate at this location.")
			else
				if(closeBusiness['owner'] == GetPlayerName(source))then
					SendPlayerChatMessage(source, "^1You cannot overtake your own company!.")
				else
					
					local overTakeMoney = math.ceil(closeBusiness['price']*1.8)
					
					if(tonumber(Users[GetPlayerName(source)]['money']) >= overTakeMoney)then
						SendPlayerChatMessage(source, "^1You succesfully overtook: "..closeBusiness['name'].." for: ^2$"..overTakeMoney)
						MySQL:executeQuery("UPDATE businesses SET price='@newPrice' WHERE name = '@name'",
						{['@newPrice'] = overTakeMoney, ['@name'] = closeBusiness['name']})
						MySQL:executeQuery("UPDATE businesses SET owner='@newPrice' WHERE name = '@name'",
						{['@newPrice'] = GetPlayerName(source), ['@name'] = closeBusiness['name']})
						
						Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] - overTakeMoney
						TriggerClientEvent("deducted", source, overTakeMoney)
						saveMoney(source)
					else
						SendPlayerChatMessage(source, "^1You don't have enough money to overtake! You need: ^2$"..overTakeMoney)
					end
				
				end
			end
		elseif(command[2] == "create" and tonumber(Users[GetPlayerName(source)]['admin']) >= 1)then

			local playerLoc = Player_Coords[GetPlayerName(source)]

			local income = math.ceil((tonumber(command[4]) / 100)*12.5)

			MySQL:executeQuery("INSERT INTO businesses (`x`, `y`, `z`, `name`, `owner`, `price`, `income`) VALUES ('@x', '@y', '@z', '@name', '', '@price', '@income')",
			{['@x'] = tonumber(playerLoc['x']), ['@y'] = tonumber(playerLoc['y']),['@z'] = tonumber(playerLoc['z']), ['@name'] = command[3], ['@price'] = tonumber(command[4]), ['@income'] = income})
			
			
			
			TriggerClientEvent("addMarker", source, tostring(playerLoc['x']), tostring(playerLoc['y']), tostring(playerLoc['z']), 0, 0, 255)
			SendPlayerChatMessage(source, "^2Company created: Name = "..command[3]..", Price = "..command[4]..", Income = "..income) 
		end
		return true
	end
	return false
end