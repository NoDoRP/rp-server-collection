RegisterServerEvent('CheckMoneyForVeh')
AddEventHandler('CheckMoneyForVeh', function(vehicle,price)
	if (tonumber(Users[GetPlayerName(source)]['money']) >= tonumber(price)) then
		if(Users[GetPlayerName(source)]['personalvehicle'] == nil or Users[GetPlayerName(source)]['personalvehicle'] == "")then
			Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] - price
			saveMoney(source)
			Users[GetPlayerName(source)]['personalvehicle'] = vehicle
			Users[GetPlayerName(source)]['pv_price'] = price
			savePersonalVehicle(source)
			TriggerClientEvent('FinishMoneyCheckForVeh',source)
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1You just bought the vehicle for ^2??"..price)
		else
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1Please sell your current vehicle first using: /pv sell")
		end
	else
		TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1You do not have enough money to buy this. You need: ^2??"..price)
	end
end)

function personalVehicleChatCommands(source, command)
	if(command[1] == "/pv") then	
		if(command[2] ~= nil)then			
			if(command[2] == "customize")then
				if(command[3] == nil)then
					TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1Available options")
					TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "color [Red] [Green] [Blue]")
					TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "upgrade")
				else
					if(Users[GetPlayerName(source)]['personalvehicle'] ~= nil or Users[GetPlayerName(source)]['personalvehicle'] ~= "")then
						if(command[3] == "upgrade")then
							TriggerClientEvent("upgradePlayerVehicle", source)
							TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^2Upgraded personal vehicle.")
						elseif(command[3] == "color")then
							TriggerClientEvent("personalVehicleColor", source, command[4], command[5], command[6])
							TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^2Set personal vehicle colour succesfully.")
						elseif(command[3] == "colorp")then
							TriggerClientEvent("personalVehicleColorPrimary", source, command[4], command[5], command[6])
							TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^2Set personal vehicle colour primary succesfully.")
						elseif(command[3] == "colors")then
							TriggerClientEvent("personalVehicleColorSecondary", source, command[4], command[5], command[6])
							TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^2Set personal vehicle colour secondary succesfully.")
						elseif(command[3] == "fix")then
							TriggerClientEvent("fixPersonalVehicle", source)
							TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^2Fixed personal vehicle succesfully.")
						else
							TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1Available options")
							TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "color [Red] [Green] [Blue]")
							TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "upgrade")
							TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "fix")
						end
					else
					TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1You currently do not have a personal vehicle.")
					end
				end
			elseif(command[2] == "sell")then
				if(Users[GetPlayerName(source)]['personalvehicle'] ~= nil or Users[GetPlayerName(source)]['personalvehicle'] ~= "")then
					Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] + (tonumber(Users[GetPlayerName(source)]['pv_price'])/2)
					saveMoney(source)
					TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1You sold your vehicle for: ^2$"..(tonumber(Users[GetPlayerName(source)]['pv_price'])/2))
					Users[GetPlayerName(source)]['personalvehicle'] = ""
					Users[GetPlayerName(source)]['pv_price'] = 0
					savePersonalVehicle(source)
				else
					TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1You currently do not have a personal vehicle.")
				end
			else
				TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1Not a valid parameter these are valid: sell")
			end
			
		else
			if(Users[GetPlayerName(source)]['personalvehicle'] ~= nil)then
				TriggerClientEvent("createCarAtPlayerPos", source, Users[GetPlayerName(source)]['personalvehicle'], true)
				TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^2You spawned your personal vehicle! To customize: /pv customize")
			else
				TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1You do not have a personal vehicle.")
			end
		end
		
		return true
	end
end
