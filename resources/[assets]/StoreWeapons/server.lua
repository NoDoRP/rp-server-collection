AddEventHandler('chatMessage', function(source, name, msg)
	if msg == "/shotgun" then
		CancelEvent()
		TriggerClientEvent('stowShotgun', source)
	elseif msg == "/carbine" then
		CancelEvent()
		TriggerClientEvent('stowRifle', source)
	end
end)