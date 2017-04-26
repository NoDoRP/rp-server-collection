--0x5EF9FEC4 = Combat Pistol
--0x678B81B1 = Nightstick
--0x83BF0278 = Carbine Rifle
--0x1D073A89 = Pump Shotgun
--0x3656C8C1 = Taser
--0x8BB05FD7 = Flashlight

RegisterNetEvent('giveLoadout')

AddEventHandler('giveLoadout', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		GiveWeaponToPed(ped, 0x5EF9FEC4, 100, false, true);
		GiveWeaponToPed(ped, 0x678B81B1, 1, false, true);
		GiveWeaponToPed(ped, 0x83BF0278, 100, false, true);
		GiveWeaponToPed(ped, 0x1D073A89, 100, false, true);
		GiveWeaponToPed(ped, 0x3656C8C1, 1, false, true);
		GiveWeaponToPed(ped, 0x8BB05FD7, 1, false, true);
		SetPedArmour(ped, 400);
		TriggerEvent('chatMessage', "^4ALERT", {255, 0, 0}, "^0Loadout given.");
	end
end)