Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedBeingStunned(GetPlayerPed(-1)) then
		ragdol = 1
		end
	end
end)
