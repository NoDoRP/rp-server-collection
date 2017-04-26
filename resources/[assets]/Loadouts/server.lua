AddEventHandler('chatMessage', function(source, name, msg)
	if msg == "/loadout" then
		CancelEvent();
		TriggerClientEvent('giveLoadout', source);
	end
end)