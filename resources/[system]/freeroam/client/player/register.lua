RegisterNetEvent("AwesomeFreeze")
RegisterNetEvent("AwesomeInvisible")
RegisterNetEvent("AwesomeGod")
RegisterNetEvent("spawnWeaponForPlayer")
RegisterNetEvent("AwesomeSetWanted")
RegisterNetEvent("getTopPlayer")

-- Spawning
-- Spawn stuff
SpawnPositions = {
	{179.0, -681.0, 43.0},
	{86.0, -691.0, 44.0},
	{97.0, -757.0, 46.0},
	{197.8, -649.0, 43.1}
}

--[[
exports.spawnmanager:setAutoSpawnCallback(function()
	local spawnPos = SpawnPositions[math.random(1, 4)]
	exports.spawnmanager:spawnPlayer({ x = spawnPos[1], y = spawnPos[2], z = spawnPos[3], model = 'player_one'}, function()
		Citizen.Trace("spowned!\n")
	end)
end)
]]

AddEventHandler('AwesomeSetWanted', function(level)
	SetPlayerWantedLevel(PlayerId(), level, false)
	SetPlayerWantedLevelNow(PlayerId(), false)
end)

AddEventHandler('AwesomeFreeze', function(freeze)
    Citizen.CreateThread(function()
		Citizen.Wait(500)
		local ped = GetPlayerPed(-1)

		if not freeze then
			FreezeEntityPosition(ped, false)
			SetPlayerControl(ped, true, true)
		else
			FreezeEntityPosition(ped, true)
			SetPlayerControl(ped, false, false)
			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
    end)
end)

AddEventHandler('AwesomeGod', function(godmode)
    Citizen.CreateThread(function()
		Citizen.Wait(500)
		local ped = GetPlayerPed(-1)

		if not godmode then
			SetEntityInvincible(GetPlayerPed(-1), false)
		else
			SetEntityInvincible(GetPlayerPed(-1), true)
		end
    end)
end)

AddEventHandler('spawnWeaponForPlayer', function(weapon)
	Citizen.CreateThread(function()
        Citizen.Wait(50)
        local weaponid = GetHashKey(weapon)
        local playerPed = GetPlayerPed(-1)
        if playerPed and playerPed ~= -1 then
			TriggerEvent('chatMessage', 'SYSTEM', {0, 255, 0}, "🔫 Weapon spawned for: ^2💲400")
			GiveWeaponToPed(playerPed, weaponid, 500, true, true)			
        end
    end)
end)

AddEventHandler('AwesomeInvisible', function(invisible)
    Citizen.CreateThread(function()
		Citizen.Wait(500)
		local ped = GetPlayerPed(-1)

		if not invisible then
			if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
				SetEntityCollision(ped, true)
			end
			
			--SetCharNeverTargetted(ped, false)
			SetPlayerInvincible(player, false)
		else
			if IsEntityVisible(ped) then
				SetEntityVisible(ped, false)
			end

			SetEntityCollision(ped, false)
			--SetCharNeverTargetted(ped, true)
			SetPlayerInvincible(player, true)
			--RemovePtfxFromPed(ped)

			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
    end)
end)