RegisterNetEvent("setHealth")
RegisterNetEvent("setArmour")

AddEventHandler("setHealth", function(health)
	SetEntityHealth(GetPlayerPed(-1), 200)
end)

local playerVehicle = nil
local lastSpawnedVehicle = nil

AddEventHandler("setArmour", function(armour)
	SetPedArmour(GetPlayerPed(-1), armour)
end)

RegisterNetEvent("createCarAtPlayerPos")
AddEventHandler('createCarAtPlayerPos', function(message, personal)
    Citizen.CreateThread(function()
        Citizen.Wait(50)
        local carid = GetHashKey(message)
        local playerPed = GetPlayerPed(-1)
        if playerPed and playerPed ~= -1 then
            RequestModel(carid)
            while not HasModelLoaded(carid) do
                Citizen.Wait(0)
            end
            local playerCoords = GetEntityCoords(playerPed)
            playerCoords = playerCoords + vector3(0, 2, 0)
			
			if(lastSpawnedVehicle ~= nil)then				
				SetEntityCoords(lastSpawnedVehicle, -1932.0, -1299.0, -12.0)
			end
			
            lastSpawnedVehicle = CreateVehicle(carid, playerCoords, 0.0, true, false)
			TaskWarpPedIntoVehicle(playerPed, lastSpawnedVehicle, -1)
			
			if(personal)then
				playerVehicle = lastSpawnedVehicle
			end
        end
    end)
end)
RegisterNetEvent('BoughtPv')
AddEventHandler('BoughtPv', function(veh)
	if(lastSpawnedVehicle ~= nil)then				
		SetEntityCoords(lastSpawnedVehicle, -1932.0, -1299.0, -12.0)
	end
	lastSpawnedVehicle = veh
	playerVehicle = veh
end)

RegisterNetEvent("upgradePlayerVehicle")
AddEventHandler("upgradePlayerVehicle", function()
	if(playerVehicle ~= nil)then
		SetVehicleModKit(playerVehicle, 0)
		ToggleVehicleMod(playerVehicle, 18, true)
		ToggleVehicleMod(playerVehicle, 22, true)
		SetVehicleMod(playerVehicle, 16, 5, true)
		SetVehicleMod(playerVehicle, 12, 2, true)
		SetVehicleMod(playerVehicle, 11, 3, true)
		SetVehicleMod(playerVehicle, 14, 14, true)
		SetVehicleMod(playerVehicle, 15, 3, true)
		SetVehicleMod(playerVehicle, 13, 2, true)
		SetVehicleWheelType(playerVehicle, 6)
		SetVehicleWindowTint(playerVehicle, 5)
		SetVehicleMod(playerVehicle, 23, 19, true)
		SetVehicleMod(playerVehicle, 0, 1, true)
		SetVehicleMod(playerVehicle, 1, 1, true)
		SetVehicleMod(playerVehicle, 2, 1, true)
		SetVehicleMod(playerVehicle, 3, 1, true)
		SetVehicleMod(playerVehicle, 4, 1, true)
		SetVehicleMod(playerVehicle, 5, 1, true)
		SetVehicleMod(playerVehicle, 6, 1, true)
		SetVehicleMod(playerVehicle, 7, 1, true)
		SetVehicleMod(playerVehicle, 8, 1, true)
		SetVehicleMod(playerVehicle, 9, 1, true)
		SetVehicleMod(playerVehicle, 10, 1, true)
	end
end)

RegisterNetEvent("fixPersonalVehicle")
AddEventHandler("fixPersonalVehicle", function()
	if(playerVehicle ~= nil)then
		SetVehicleFixed(playerVehicle)
	end
end)

RegisterNetEvent("personalVehicleColor")
AddEventHandler("personalVehicleColor", function(r, g, b)
	if(playerVehicle ~= nil)then
		SetVehicleCustomPrimaryColour(playerVehicle, tonumber(r), tonumber(g), tonumber(b))
		SetVehicleCustomSecondaryColour(playerVehicle, tonumber(r), tonumber(g), tonumber(b))
	end
end)

RegisterNetEvent("personalVehicleColorPrimary")
AddEventHandler("personalVehicleColorPrimary", function(r, g, b)
	if(playerVehicle ~= nil)then
		SetVehicleCustomPrimaryColour(playerVehicle, tonumber(r), tonumber(g), tonumber(b))
	end
end)

RegisterNetEvent("personalVehicleColorSecondary")
AddEventHandler("personalVehicleColorSecondary", function(r, g, b)
	if(playerVehicle ~= nil)then
		SetVehicleCustomSecondaryColour(playerVehicle, tonumber(r), tonumber(g), tonumber(b))
	end
end)