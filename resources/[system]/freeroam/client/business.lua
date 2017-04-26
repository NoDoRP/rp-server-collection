local Markers = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local playerPed = GetPlayerPed(-1)
		if playerPed and playerPed ~= -1 then
			local playerCoords = GetEntityCoords(playerPed)
			if(playerCoords ~= nil)then
				TriggerServerEvent("playerCoordsBus", playerCoords['x'], playerCoords['y'], playerCoords['z'])
			end
		end
	end
end)

local function getDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterNetEvent("addMarker")
AddEventHandler("addMarker", function(x, y, z, r, g, b)
	local id = #Markers+1
	
	Markers[id] = {}
	
	Markers[id]['x'] = tonumber(x)
	Markers[id]['y'] = tonumber(y)
	Markers[id]['z'] = tonumber(z)
	Markers[id]['r'] = tonumber(r)
	Markers[id]['g'] = tonumber(g)
	Markers[id]['b'] = tonumber(b)
end)

RegisterNetEvent("thisPos")
AddEventHandler("thisPos", function()
	Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(playerPed)
		while true do
			Citizen.Wait(0)
			
			DrawMarker(1, playerCoords['x'], playerCoords['y'], playerCoords['z'], 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.0001, 0, 0, 255,255, 0,0, 0,0)
		end
	end)	
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i, name in ipairs(Markers) do
			if(Markers[i]['x'] ~= nil and Markers[i]['y'] ~= nil and Markers[i]['z'] ~= nil)then
				local playerPed = GetPlayerPed(-1)
				local playerCoords = GetEntityCoords(playerPed)			
				if(playerCoords ~= nil)then
					local Distance = Vdist(playerCoords['x'],playerCoords['y'],playerCoords['z'], Markers[i]['x'], Markers[i]['y'], Markers[i]['z'])
					
					if(Distance < 5 and IsControlJustReleased(0, 38))then
						TriggerServerEvent("useFunction", Markers[i]['r'], Markers[i]['g'], Markers[i]['b'])
					end
					
					if(Distance < 55)then
						DrawMarker(1, Markers[i]['x'], Markers[i]['y'], Markers[i]['z'] - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.0001, Markers[i]['r'], Markers[i]['g'], Markers[i]['b'],155, 0,0, 0,0)
					end
				end

					
			end
		end
	end
end)