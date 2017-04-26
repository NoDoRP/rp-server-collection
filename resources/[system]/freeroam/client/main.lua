local playerVehicle = nil
local lastSpawnedVehicle = nil

RegisterNetEvent("spawnObject")
AddEventHandler("spawnObject", function()
	Citizen.CreateThread(function()
		local objectID = GetHashKey("stt_prop_c4_stack")
		
		RequestModel(objectID)
		while not HasModelLoaded(objectID) do
			Citizen.Wait(0)
		end
		
		local playerCoords = GetEntityCoords(playerPed)
        playerCoords = playerCoords + vector3(0, 2, 0)
		
		CreateObject(objectID, playerCoords['x'], playerCoords['y'], playerCoords['z'], true, true, true)
	end)
end)