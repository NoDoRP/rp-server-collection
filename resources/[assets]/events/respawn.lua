Citizen.CreateThread(function()
    while true do
        Wait(0)
		local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        if IsEntityDead(GetPlayerPed(-1)) then 
            Wait(5000)
            NetworkResurrectLocalPlayer(plyPos, true, true, false)
			ClearPedTasks(playerPed)
			Wait(1000)
			ragdol = 1
			DisableControlAction(2, 303, true)
			DisableControlAction(2, 246, true)
        		TriggerEvent("chatMessage", "[INFO]", { 255,0,0}, "Wait for paramedics to resurect you.")
        end
    end
end)
