AddEventHandler('chatMessage', function(source, name, msg)
	if msg == "/help" then
		CancelEvent();
		TriggerClientEvent('showHelp', source);
	elseif msg == "/commands" then
		CancelEvent();
		TriggerClientEvent('showCommands', source);
	elseif msg == "/rules" then
		CancelEvent();
		TriggerClientEvent('showRules', source);
	end
end)