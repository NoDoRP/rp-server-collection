RegisterNetEvent('showHelp');
RegisterNetEvent('showCommands');
RegisterNetEvent('showRules');

AddEventHandler('showHelp', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0--------HELP--------");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0Please make note of our server rules using /rules");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0Also please take the time to read our command using /commands");
	end
end)

AddEventHandler('showCommands', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0--------COMMANDS--------");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0/dv | Deletes your current vehicle.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0/hu | Lowers/Raises your hands.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0/showid [first] [last] | Shows your ID.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0/ncic [first] [last] | Runs the subject.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0/runplate [plate] | Runs the license plate.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0/vin | Checks the status of a vehicle's VIN.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0/shotgun | Stores/Retrieves shotgun from your vehicle.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0/carbine | Stores/Retrieves carbine from your vehicle.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0/emotes | Displays a list of available emotes.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0/emote [emote] | Plays the specified emote.");
	end
end)

AddEventHandler('showRules', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0--------RULES--------");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0No use of military vehicles.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0No use of any and all aircraft if you're a civ.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0No use of heavy weapons.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0No use of explosives.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0No use of any powerful weapons.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0If you're pitted or sustain alot of damage, stop.");
		TriggerEvent('chatMessage', "^3Server", {255, 0, 0}, "^0Absolutely no RDM (Random Deathmatch).");
	end
end)