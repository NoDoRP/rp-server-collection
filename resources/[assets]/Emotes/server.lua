AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	if sm[1] == "/emotes" then
		CancelEvent();
		TriggerClientEvent('printEmoteList', source);
	elseif sm[1] == "/emote" then
		CancelEvent();
		if sm[2] == nil or sm[2] == "" then
			TriggerClientEvent('printInvalidEmote', source);
		elseif sm[2] == "cop" then
			TriggerClientEvent('playCopEmote', source);
		elseif sm[2] == "sit" then
			TriggerClientEvent('playSitEmote', source);
		elseif sm[2] == "chair" then
			TriggerClientEvent('playChairEmote', source);
		elseif sm[2] == "kneel" then
			TriggerClientEvent('playKneelEmote', source);
		elseif sm[2] == "medic" then
			TriggerClientEvent('playMedicEmote', source);
		elseif sm[2] == "notepad" then
			TriggerClientEvent('playNotepadEmote', source);
		elseif sm[2] == "traffic" then
			TriggerClientEvent('playTrafficEmote', source);
		elseif sm[2] == "photo" then
			TriggerClientEvent('playPhotoEmote', source);
		elseif sm[2] == "clipboard" then
			TriggerClientEvent('playClipboardEmote', source);
		elseif sm[2] == "lean" then
			TriggerClientEvent('playLeanEmote', source);
		end
	end
end)

function stringsplit(self, delimiter)
	local a = self:Split(delimiter)
	local t = {}
	
	for i = 0, #a - 1 do
		table.insert(t, a[i])
	end
	
	return t
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

function setContains(set, key)
    return set[key] ~= nil
end