-- Loading MySQL Class
require "resources/freeroam/lib/MySQL"

Players_Currently_Robbing = {}
Recently_Robbed = {}
Players_Running = {}

function test222()
	print("es")
end

RegisterServerEvent("baseevents:onPlayerDied")
AddEventHandler("baseevents:onPlayerDied", function(k,e)
	if(Players_Running[GetPlayerName(source)] ~= nil)then
		Players_Running[GetPlayerName(source)] = nil
		SendPlayerChatMessage(source, "^1You died, you lost the your money!")
	end
end)

RegisterServerEvent("baseevents:onPlayerKilled")
AddEventHandler("baseevents:onPlayerKilled", function(k,e)
	if(Players_Running[GetPlayerName(source)] ~= nil)then
		Players_Running[GetPlayerName(source)] = nil
		SendPlayerChatMessage(source, "^1You died, you lost the your money!")
	end
end)

local function roundToFirstDecimal(t)
    return math.ceil(t*10)*0.1
end

function robDone(source, robbable, level)
	if(GetPlayerName(source) ~= nil)then
		local RunTime = tonumber(robbable['jackpot'])
	
		if(level ~= 5)then
			SendPlayerChatMessage(source, "^1You started running, hold off the cops for "..roundToFirstDecimal(math.ceil(robbable['jackpot']/1000)/60).." minutes!")
		else
			SendPlayerChatMessage(source, "^1You started running, hold off the cops for "..roundToFirstDecimal(RunTime/60).." minutes!")
		end
		
		local wantedLevelWas = level
		
		Players_Running[GetPlayerName(source)] = true
		SetTimeout(RunTime, function()
			if(GetPlayerName(source) ~= nil)then
				if(Players_Running[GetPlayerName(source)] == nil)then
				else				
					local payout = math.ceil((robbable['jackpot']/5)*level)
					Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] + payout
					TriggerClientEvent("clientPlayerData", source, Users[GetPlayerName(source)]['money'])
				
					Players_Currently_Robbing[GetPlayerName(source)] = nil
					Recently_Robbed[robbable['id']] = true
					
					SendPlayerChatMessage(source, "^1You lost the cops, good job you got: ^2$"..payout)
					
					TriggerClientEvent("setWantedHeist", source, 0)
					
				end
				
				local timeout = math.ceil(robbable['jackpot']*2)
				SetTimeout(timeout, function()
					Recently_Robbed[robbable['id']] = false
				end)					
			end
		end)
	end	
end

function robTimer(source, robbable, ran)
	SetTimeout(20000,function()
		if(GetPlayerName(source) ~= nil)then
			if(Players_Running[GetPlayerName(source)] == nil)then
			else
				local plyLocation = Player_Coords[GetPlayerName(source)]
				if(getDistance(tonumber(robbable['x']),tonumber(robbable['y']), tonumber(robbable['z']), tonumber(plyLocation['x']), tonumber(plyLocation['y']), tonumber(plyLocation['z'])) < 14)then
					SendPlayerChatMessage(source, "^2Wanted level increased, but you get more money!")
					TriggerClientEvent("setWantedHeist", source, tonumber(ran+1))
					Players_Running[GetPlayerName(source)] = true
					
					if(ran+1 == 5)then
						robDone(source, robbable, ran)
					else
						robTimer(source, robbable, ran+1)
					end
				else
					robDone(source, robbable, ran)
				end
			end
		end
	end)
end

function playerIsRobbing(source, robbable)
	if(Players_Currently_Robbing[GetPlayerName(source)] == nil)then
		if(Recently_Robbed[robbable['id']] == true)then
			SendPlayerChatMessage(source, "^1This place has been recently robbed. Please wait.")
		else

			Players_Currently_Robbing[GetPlayerName(source)] = robbable['id']
			Players_Running[GetPlayerName(source)] = true
			TriggerClientEvent("setWantedHeist", source, 1)
			SendPlayerChatMessage(source, "^2You started robbing! When you want to leave, leave!")
			
			robTimer(source, robbable, 1)
		end
	else
		SendPlayerChatMessage(source, "^1You are already robbing a place!")
	end
end

function getDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

function commandManagerHeistJob(source, command)
	
	if(command[1] == "/rob")then
		local executed_query = MySQL:executeQuery("SELECT * FROM robbables")
		local result = MySQL:getResults(executed_query, {'x', 'y', 'z', 'name', 'jackpot', 'id'})		
		
		local closeRobbable = nil
		
		local plyLocation = Player_Coords[GetPlayerName(source)]
		print(plyLocation)
		
		for i, name in ipairs(result) do
			if(getDistance(tonumber(result[i]['x']),tonumber(result[i]['y']), tonumber(result[i]['z']), tonumber(plyLocation['x']), tonumber(plyLocation['y']), tonumber(plyLocation['z'])) < 4)then
				closeRobbable = result[i]
			end
		end
		
		if(closeRobbable ~= nil)then
			if(command[2] == nil)then
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
		else		
			if(command[2] == "create" and tonumber(Users[GetPlayerName(source)]['admin']) >= 1)then
				local playerLoc = Player_Coords[GetPlayerName(source)]
				
				MySQL:executeQuery("INSERT INTO robbables (`x`, `y`, `z`, `name`, `jackpot`) VALUES ('@x', '@y', '@z', '@name', '@jackpot' )",
				{['@x'] = playerLoc['x'], ['@y'] = playerLoc['y'],['@z'] = playerLoc['z'], ['@name'] = command[3], ['@jackpot'] = tonumber(command[4])})
				
				TriggerClientEvent("addMarker", source, tostring(playerLoc['x']), tostring(playerLoc['y']), tostring(playerLoc['z']), 0, 0, 0, 'robbable')
				SendPlayerChatMessage(source, "^2Robbable created: Name = "..command[3]..", Jackpot = "..command[4]) 
			else
				SendPlayerChatMessage(source, "^1There is no robbable place at this location.")
			end
			
		end
		
		return true	
	end
end