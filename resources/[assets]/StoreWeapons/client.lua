RegisterNetEvent('stowShotgun')
RegisterNetEvent('stowRifle')

shotgun_stored = false
rifle_stored = false

AddEventHandler('stowShotgun', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if shotgun_stored == true then
			GiveWeaponToPed(ped, 0x1D073A89, 100, false, true);
			TriggerEvent('chatMessage', "ACTION", {255, 0, 0}, "^0Retrieved shotgun.");
			shotgun_stored = false;
		elseif shotgun_stored == false then
			if HasPedGotWeapon(ped, 0x1D073A89, false) then
				RemoveWeaponFromPed(ped, 0x1D073A89);
				TriggerEvent('chatMessage', "ACTION", {255, 0, 0}, "^0Stored shotgun.");
				shotgun_stored = true;
			else
				TriggerEvent('chatMessage', "^4ALERT", {255, 0, 0}, "^1You do not have a shotgun.");
				return
			end
		end
	end
end)

AddEventHandler('stowRifle', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if rifle_stored == true then
			GiveWeaponToPed(ped, 0x83BF0278, 100, false, true);
			TriggerEvent('chatMessage', "ACTION", {255, 0, 0}, "^0Retrieved carbine.");
			rifle_stored = false;
		elseif rifle_stored == false then
			if HasPedGotWeapon(ped, 0x83BF0278, false) then
				RemoveWeaponFromPed(ped, 0x83BF0278);
				TriggerEvent('chatMessage', "ACTION", {255, 0, 0}, "^0Stored carbine.");
				rifle_stored = true;
			else
				TriggerEvent('chatMessage', "^4ALERT", {255, 0, 0}, "^1You do not have a carbine.");
				return
			end
		end
	end
end)