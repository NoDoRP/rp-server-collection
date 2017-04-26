AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	
	if sm[1] == "/showid" then
		CancelEvent();
		if tablelength(sm) > 1 then
			random_month = math.random(1, 12);
			random_day = math.random(1, 31);
			random_year = math.random(1936, 2002);
			TriggerClientEvent('chatMessage', -1, "^4ID", {255, 0, 0}, GetPlayerName(source) .. "(#" .. source .. ") shows ID: First: ^2" .. sm[2] .. "^0, Last: ^2" .. sm[3] .. "^0 | DOB:^2" .. random_month .. "/" .. random_day .. "/" .. random_year);
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