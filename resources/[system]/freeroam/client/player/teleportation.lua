RegisterNetEvent("teleportToPlayer")
AddEventHandler("teleportToPlayer", function(message)
	local playerPed = GetPlayerPed(-1)
	local teleportPed = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(message)))) 
	SetEntityCoords(playerPed, teleportPed)
end)

RegisterNetEvent("teleportToSender")
AddEventHandler("teleportToSender", function(message)
	local playerPed = GetPlayerPed(-1)
	local teleportPed = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(message)))) 
	SetEntityCoords(playerPed, teleportPed)
end)

-- Spawn stuff
SpawnPositions = {
	{179.0, -681.0, 43.0},
	{86.0, -691.0, 44.0},
	{97.0, -757.0, 46.0},
	{197.8, -649.0, 43.1}
}

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

RegisterNetEvent("teleportSpawning")
AddEventHandler("teleportSpawning", function()
	Citizen.CreateThread(function()
		Citizen.Wait(500)
		local playerPed = GetPlayerPed(-1)
		local spawnPos = SpawnPositions[math.random(1, 4)]
		SetEntityCoords(playerPed, spawnPos[1], spawnPos[2], spawnPos[3])
	end)
end)

RegisterNetEvent("getPosition")
AddEventHandler("getPosition", function(message)
	local playerPed = GetPlayerPed(-1)
	local teleportPed = GetEntityCoords(playerPed) 
	TriggerEvent('chatMessage', 'SYSTEM', {0, 255, 0}, ":"..teleportPed)
end)