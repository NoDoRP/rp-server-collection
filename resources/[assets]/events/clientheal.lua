RegisterNetEvent("heal")
AddEventHandler('heal', function()
	local ped = GetPlayerPed(-1)
	if DoesEntityExist(ped) and not IsEntityDead(ped) then
		SetEntityHealth(ped, 200)
		ragdol = 0
	end
end)
