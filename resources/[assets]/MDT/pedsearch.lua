AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	has_warrant = false;
	caution_code = "";
	
	--Vehicle search vars
	has_file = false;
	has_insurance = false;
	has_registration = false;
	is_stolen = false;
	reg_type = "";
	
	if sm[1] == "/ncic" then
		CancelEvent();
		if tablelength(sm) > 1 then
			random_tickets = math.random(0, 5);
			random_arrests = math.random(0, 5);
			random_warrant = math.random(0, 100);
			random_caution = math.random(0, 100);
			if random_warrant <= 8 then
				has_warrant = true;
			end
			
			if random_caution >= 30 and random_caution < 40 then
				caution_code = caution_code .. "M ";
			elseif random_caution >= 40 and random_caution < 50 then
				caution_code = caution_code .. "A ";
			end
			
			if has_warrant == true then
				if caution_code == "" then
					TriggerClientEvent('chatMessage', source, "^1NCIC", {255, 0, 0}, "^0History for " .. sm[2] .. " " .. sm[3] .. ": " .. random_tickets .. " ticket(s), " .. random_arrests .. " arrest(s). Wants & Warrants: ^1W; ^0Caution Code(s): ^2None");
				else
					TriggerClientEvent('chatMessage', source, "^1NCIC", {255, 0, 0}, "^0History for " .. sm[2] .. " " .. sm[3] .. ": " .. random_tickets .. " ticket(s), " .. random_arrests .. " arrest(s). Wants & Warrants: ^1W; ^0Caution Code(s): ^1" .. caution_code);
				end
			else
				if caution_code == "" then
					TriggerClientEvent('chatMessage', source, "^1NCIC", {255, 0, 0}, "^0History for " .. sm[2] .. " " .. sm[3] .. ": " .. random_tickets .. " ticket(s), " .. random_arrests .. " arrest(s). Wants & Warrants: ^2None; ^0Caution Code(s): ^2None");
				else
					TriggerClientEvent('chatMessage', source, "^1NCIC", {255, 0, 0}, "^0History for " .. sm[2] .. " " .. sm[3] .. ": " .. random_tickets .. " ticket(s), " .. random_arrests .. " arrest(s). Wants & Warrants: ^2None; ^0Caution Code(s): ^1" .. caution_code);
				end
			end
		end
	elseif sm[1] == "/runplate" then
		CancelEvent();
		if tablelength(sm) > 1 then
			random_nofile = math.random(0, 100);
			random_noins = math.random(0, 100);
			random_noreg = math.random(0, 100);
			random_stolen = math.random(0, 100);
			if random_nofile <= 25 then
				has_file = false;
			else
				has_file = true;
			end
			
			if random_noins <= 10 then
				has_insurance = false;
			else
				has_insurance = true;
			end
			
			if random_noreg <= 20 and random_noreg > 15 then
				has_registration = false;
				reg_type = "None";
			elseif random_noreg <= 25 and random_noreg > 20 then
				has_registration = false;
				reg_type = "Expired Registration";
			else
				has_registration = true;
				reg_type = "Valid";
			end
			
			if random_stolen <= 5 then
				is_stolen = true;
			else
				is_stolen = false;
			end
			
			if is_stolen == true then
				if has_insurance == false then
					if reg_type == "Valid" then
						TriggerClientEvent('chatMessage', source, "^1DMV", {255, 0, 0}, "^0Records for " .. sm[2] .. ": ^0Stolen: ^0Flagged as stolen^0, ^0Insurance: ^1None^0, ^0Registration: ^2" .. reg_type);
					else
						TriggerClientEvent('chatMessage', source, "^1DMV", {255, 0, 0}, "^0Records for " .. sm[2] .. ": ^0Stolen: ^0Flagged as stolen^0, ^0Insurance: ^1None^0, ^0Registration: ^1" .. reg_type);
					end
				else
					if reg_type == "Valid" then
						TriggerClientEvent('chatMessage', source, "^1DMV", {255, 0, 0}, "^0Records for " .. sm[2] .. ": ^0Stolen: ^1Flagged as stolen^0, ^0Insurance: ^2Valid^0, ^0Registration: ^2" .. reg_type);
					else
						TriggerClientEvent('chatMessage', source, "^1DMV", {255, 0, 0}, "^0Records for " .. sm[2] .. ": ^0Stolen: ^1Flagged as stolen^0, ^0Insurance: ^2Valid^0, ^0Registration: ^1" .. reg_type);
					end
				end
			elseif is_stolen == false then
				if has_insurance == false then
					if reg_type == "Valid" then
						TriggerClientEvent('chatMessage', source, "^1DMV", {255, 0, 0}, "^0Records for " .. sm[2] .. ": ^0Stolen: ^2Clear^0, ^0Insurance: ^1None^0, ^0Registration: ^2" .. reg_type);
					else
						TriggerClientEvent('chatMessage', source, "^1DMV", {255, 0, 0}, "^0Records for " .. sm[2] .. ": ^0Stolen: ^2Clear^0, ^0Insurance: ^1None^0, ^0Registration: ^1" .. reg_type);
					end
				else
					if reg_type == "Valid" then
						TriggerClientEvent('chatMessage', source, "^1DMV", {255, 0, 0}, "^0Records for " .. sm[2] .. ": ^0Stolen: ^2Clear^0, ^0Insurance: ^2Valid^0, ^0Registration: ^2" .. reg_type);
					else
						TriggerClientEvent('chatMessage', source, "^1DMV", {255, 0, 0}, "^0Records for " .. sm[2] .. ": ^0Stolen: ^2Clear^0, ^0Insurance: ^2Valid^0, ^0Registration: ^1" .. reg_type);
					end
				end
			end
		end
	elseif sm[1] == "/vin" then
		CancelEvent();
		stolen_chance = math.random(0, 100);
		if stolen_chance <= 15 then
			TriggerClientEvent('chatMessage', source, "^1DMV", {255, 0, 0}, "^1VIN flagged as stolen!");
		else
			TriggerClientEvent('chatMessage', source, "^1DMV", {255, 0, 0}, "^2VIN clear.");
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