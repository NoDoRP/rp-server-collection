RegisterNetEvent('printInvalidEmote');
RegisterNetEvent('printEmoteList');
RegisterNetEvent('playCopEmote');
RegisterNetEvent('playSitEmote');
RegisterNetEvent('playChairEmote');
RegisterNetEvent('playKneelEmote');
RegisterNetEvent('playMedicEmote');
RegisterNetEvent('playNotepadEmote');
RegisterNetEvent('playTrafficEmote');
RegisterNetEvent('playPhotoEmote');
RegisterNetEvent('playClipboardEmote');
RegisterNetEvent('playLeanEmote');

currently_playing_emote = false;

playing_cop_emote = false;
playing_sit_emote = false;
playing_chair_emote = false;
playing_kneel_emote = false;
playing_medic_emote = false;
playing_notepad_emote = false;
playing_traffic_emote = false;
playing_photo_emote = false;
playing_clipboard_emote = false;
playing_lean_emote = false;

AddEventHandler('printEmoteList', function()
	TriggerEvent('chatMessage', "^4ALERT", {255, 0, 0}, "^2Emote List: ^0cop, sit, chair, kneel, medic, notepad, traffic, photo, clipboard, lean");
end)

AddEventHandler('printInvalidEmote', function()
	TriggerEvent('chatMessage', "^4ALERT", {255, 0, 0}, "^1Invalid emote specified, use /emotes");
end)

--!!!DO NOT EDIT BELOW THIS LINE!!!

AddEventHandler('playCopEmote', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if playing_cop_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, true);
			playing_cop_emote = true;
		elseif playing_cop_emote == true then
			ClearPedTasks(ped);
			playing_cop_emote = false;
		end
	end
end)

AddEventHandler('playSitEmote', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if playing_sit_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PICNIC", 0, true);
			playing_sit_emote = true;
		elseif playing_sit_emote == true then
			ClearPedTasks(ped);
			playing_sit_emote = false;
		end
	end
end)
AddEventHandler('playChairEmote', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if playing_chair_emote == false then
			pos = GetEntityCoords(ped);
			head = GetEntityHeading(ped);
			TaskStartScenarioAtPosition(ped, "PROP_HUMAN_SEAT_CHAIR", pos['x'], pos['y'], pos['z'] - 1, head, 0, 0, 1);
			--TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_CHAIR", 0, false);
			playing_chair_emote = true;
		elseif playing_chair_emote == true then
			ClearPedTasks(ped);
			playing_chair_emote = false;
		end
	end
end)

AddEventHandler('playKneelEmote', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if playing_kneel_emote == false then
			TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_KNEEL", 0, true);
			playing_kneel_emote = true;
		elseif playing_kneel_emote == true then
			ClearPedTasks(ped);
			playing_kneel_emote = false;
		end
	end
end)

AddEventHandler('playMedicEmote', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if playing_medic_emote == false then
			TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true);
			playing_medic_emote = true;
		elseif playing_medic_emote == true then
			ClearPedTasks(ped);
			playing_medic_emote = false;
		end
	end
end)

AddEventHandler('playNotepadEmote', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if playing_notepad_emote == false then
			TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true);
			playing_notepad_emote = true;
		elseif playing_notepad_emote == true then
			ClearPedTasks(ped);
			playing_notepad_emote = false;
		end
	end
end)

AddEventHandler('playTrafficEmote', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if playing_traffic_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CAR_PARK_ATTENDANT", 0, false);
			playing_traffic_emote = true;
		elseif playing_traffic_emote == true then
			ClearPedTasks(ped);
			playing_traffic_emote = false;
		end
	end
end)

AddEventHandler('playPhotoEmote', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if playing_photo_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PAPARAZZI", 0, false);
			playing_photo_emote = true;
		elseif playing_photo_emote == true then
			ClearPedTasks(ped);
			playing_photo_emote = false;
		end
	end
end)

AddEventHandler('playClipboardEmote', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if playing_clipboard_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, false);
			playing_clipboard_emote = true;
		elseif playing_clipboard_emote == true then
			ClearPedTasks(ped);
			playing_clipboard_emote = false;
		end
	end
end)

AddEventHandler('playLeanEmote', function()
	ped = GetPlayerPed(-1);
	
	if ped then
		if playing_lean_emote == false then
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_LEANING", 0, true);
			playing_lean_emote = true;
		elseif playing_lean_emote == true then
			ClearPedTasks(ped);
			playing_lean_emote = false;
		end
	end
end)