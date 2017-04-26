-- Server

local firstspawn = true
Users = {}

RegisterServerEvent("chatCommandEntered")
RegisterServerEvent("onPlayerConnect")
RegisterServerEvent("baseevents:onPlayerKilled")

RegisterServerEvent("spawnPersonalVehicle")

AddEventHandler("spawnPersonalVehicle", function()
	if(Users[GetPlayerName(source)] ~= nil)then
		if(Users[GetPlayerName(source)]['personalvehicle'] ~= nil)then
				TriggerClientEvent("createCarAtPlayerPos", source, Users[GetPlayerName(source)]['personalvehicle'], true)
				TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^2You spawned your personal vehicle! To customize: /pv customize")
			else
				TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1You do not have a personal vehicle.")
			end
	end
end)

AddEventHandler('onPlayerConnect', function()	
	if(Users[GetPlayerName(source)] == nil)then
	-- loading
		if hasAccount(source) then
			print("User has account: "..GetPlayerName(source))
			Users[GetPlayerName(source)] = LoadUser(source)
			TriggerClientEvent("AwesomeFreeze", source, true)
			TriggerClientEvent("AwesomeInvisible", source, true)
			SendPlayerChatMessage(source, "🔒 Your account have been found on our database type ^1/login ^7[^2Your Password^7]")
		else
			TriggerClientEvent("AwesomeFreeze", source, true)
			TriggerClientEvent("AwesomeInvisible", source, true)
			
			SendPlayerChatMessage(source, "🔒 Please ^1register^7 with this command ^1/register ^7[^2Your Password^7]")
		end
	end
	TriggerClientEvent("teleportSpawning", source)
end)

-- Spawn stuff
-- Server Conencting Player

-- Server Disconnect Player
AddEventHandler('playerDropped', function(reason)
	-- Check if Usersrow is existing -> Deleting Users var at disconnect
	local localname = GetPlayerName(source)
	print("Player " .. GetPlayerName(source) .. " disconnected. Reason: "..reason)
	
	Users[localname] = nil
end)

-- Gun stuff
local spawnAbleWeapons = {"WEAPON_KNIFE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB", "WEAPON_CROWBAR","WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50", "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_ASSAULTRIFLE", "WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_PUMPSHOTGUN", "WEAPON_SAWNOFFSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_BULLPUPSHOTGUN","WEAPON_STUNGUN", "WEAPON_SNIPERRIFLE", "WEAPON_SMOKEGRENADE", "WEAPON_BZGAS", "WEAPON_MOLOTOV", "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_SNSPISTOL", "WEAPON_SPECIALCARBINE", "WEAPON_HEAVYPISTOL", "WEAPON_BULLPUPRIFLE", "WEAPON_HOMINGLAUNCHER", "WEAPON_PROXMINE", "WEAPON_SNOWBALL", "WEAPON_VINTAGEPISTOL", "WEAPON_DAGGER", "WEAPON_FIREWORK", "WEAPON_MUSKET", "WEAPON_MARKSMANRIFLE", "WEAPON_HEAVYSHOTGUN", "WEAPON_GUSENBERG", "WEAPON_HATCHET", "WEAPON_COMBATPDW", "WEAPON_KNUCKLE", "WEAPON_MARKSMANPISTOL", "WEAPON_BOTTLE", "WEAPON_FLAREGUN", "WEAPON_FLARE", "WEAPON_REVOLVER", "WEAPON_SWITCHBLADE", "WEAPON_MACHETE", "WEAPON_FLASHLIGHT", "WEAPON_MACHINEPISTOL", "WEAPON_DBSHOTGUN", "WEAPON_COMPACTRIFLE"}
local adminGuns = {"WEAPON_RAILGUN", "WEAPON_HEAVYSNIPER", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_RPG", "WEAPON_MINIGUN", "WEAPON_GRENADE", "WEAPON_STICKYBOMB"}

-- KD stuff
AddEventHandler('baseevents:onPlayerKilled', function(killer, kilerT)
	if(GetPlayerName(killer) ~= nil and GetPlayerName(source) ~= nil)then
		Users[GetPlayerName(killer)]['kills'] = tonumber(Users[GetPlayerName(killer)]['kills']) + 1
		Users[GetPlayerName(source)]['deaths'] = tonumber(Users[GetPlayerName(killer)]['deaths']) + 1
		
		saveKD(source)
		saveKD(killer)
	end
end)

AddEventHandler('chatMessage', function(source, color, message)
	command = stringsplit(message, " ")
	
	print(color .. ":" .. message)

	if(message:sub(1, 1) == "/")then
		CancelEvent()
	else
		CancelEvent()
		
		local tag = "USER"
		local color = {255, 255, 255}
		
		if(isLoggedIn(source))then
			local adminlevel = tonumber(Users[GetPlayerName(source)]['admin'])
			
			if(adminlevel == 1)then
				tag = "MODERATOR"
				color = {0, 0, 255}
			elseif(adminlevel == 2)then
				tag = "ADMINISTRATOR"
				color = {255, 0, 0}
			elseif(adminlevel == 3)then
				tag = "SUPERADMIN"
				color = {255, 0, 0}
			elseif(adminlevel > 3)then
				tag = "OWNER"
				color = {255, 0, 0}
			end
		
			TriggerClientEvent('chatMessage', -1, tag .. " | " .. GetPlayerName(source), color, message)
		end
		
		return
	end
	
	if not isLoggedIn(source) then
		if(command[1] == "/register") then
			if(command[2] ~= nil) then
				registerUser(source, command[2])
			else
				SendPlayerChatMessage(source, "USAGE: /register password", { 0, 0x99, 255})
			end
		elseif(command[1] == "/t")then
			TriggerClientEvent("thisPos", source)
		elseif(command[1] == "/login") then
			if(command[2] ~= nil) then
				loginUser(source, command[2])
			else
				SendPlayerChatMessage(source, "USAGE: /login password", { 0, 0x99, 255})
			end
		else
			
			if(hasAccount(source)) then
				SendPlayerChatMessage(source, "^1Please login first using: /login [password]", { 0, 0x99, 255})
			else
				SendPlayerChatMessage(source, "^1Please register first using: /register [password]", { 0, 0x99, 255})
			end
		end
		return
	end

	if command[1] == "/help" then
		TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "💡 Commands:")
		TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "Regular: /stats, /help, /weapon, /pv, /re")
		TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "Regular: /crew")
		TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "(^2$100^0)/vehicle [name],(^2$400^0)/buy [name]")
		TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "(^2$200^0)/heal,(^2$200^0)/armor")
		if(Users[GetPlayerName(source)]['admin'] == 1)then
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "Type ^4/helpadmin ^0for admin commands.")
		end
	elseif(command[1] == "/helpadmin") then
		if(Users[GetPlayerName(source)]['admin'] == 1)then
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "/kick [id], /(un)freeze [id], /tphere [id]")
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "/(un)god [id], /setwanted [id] [level]")
		end
	elseif(command[1] == "/vehicle") then
		if(tonumber(Users[GetPlayerName(source)]['money']) >= 100)then
			if((command[2] == "rhino" or command[2] == "lazer" or command[2] == "hydra") and tonumber(Users[GetPlayerName(source)]['admin']) < 1) then
				TriggerClientEvent("chatMessage", source, '', {0,0,0}, "^1Your not allowed to spawn that.")
			else
				TriggerClientEvent("createCarAtPlayerPos", source, command[2], false)	
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {0, 255, 0}, "🚘 Vehicle spawned for: ^2💲100")
				Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] - 100
				TriggerClientEvent("deducted", source, 100)
				saveMoney(source)
			end
		else
			TriggerClientEvent("chatMessage", source, '', {0,0,0}, "^1You do not have enough money to spawn a vehicle. You require: ^2💲100")
		end
	elseif(command[1] == "/weapon") then TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "To buy a ^1weapon^7, type ^1/buy^7 [^1weapon name^7] & to see all available weapons type:")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^1/weapon1 - Melee")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^1/weapon2 - Handguns")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^1/weapon3 - Submachine Guns")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^1/weapon4 - Shotguns")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^1/weapon5 - Assault Rifles")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^1/weapon6 - Sniper Rifles")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^1/weapon7 - Thrown/Misc")
                                   
    elseif(command[1] == "/weapon1") then TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^2🔪 Melee^7:")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "knife")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "nightstick")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "crowbar")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "golfclub")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "hammer")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "bottle")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "dagger")
   
    elseif(command[1] == "/weapon2") then TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^2🔫 Handguns^7:")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "pistol")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "combatpistol")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "appistol")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "stungun")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "pistol50")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "snspistol")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "heavypistol")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "vintagepistol")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "flare & marksmanpistol")  
                                   
    elseif(command[1] == "/weapon3") then TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^2🔫 Submachine Guns^7:")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "microsmg")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "smg")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "assaultsmg")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "combatpdw")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "mg")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "combatmg")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "gusenberg")
                                   
    elseif(command[1] == "/weapon4") then TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^2🔫 Shotguns^7:")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "pumpshotgun")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "sawnoffshotgun")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "assaultshotgun")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "bullpupshotgun")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "musket")
                                   
    elseif(command[1] == "/weapon5") then TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^2🔫 Assault Rifles^7:")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "assaultrifle")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "carbinerifle")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "advancedrifle")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "specialcarbine")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "bullpuprifle")
                                   
    elseif(command[1] == "/weapon6") then TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^2🔫 Sniper Rifles^7:")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "sniperrifle")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "heavysniper")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "marksmanrifle")
                                   
    elseif(command[1] == "/weapon7") then TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^2💣 Thrown/Misc^7:")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "grenade")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "bzgas")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "molotov")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "proxmine")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "snowball")
                                    TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "petrolcan")
	elseif(command[1] == "/buy") then
		if(command[2] == nil) then
			TriggerClientEvent("chatMessage", source, '', {0,0,0}, "^1 Enter a weapon name. For a list type: /weapon")
		else
			if(tonumber(Users[GetPlayerName(source)]['money']) >= 400)then
				local wep_name = command[2]
				local spawn_wep = nil
				
				if(tonumber(Users[GetPlayerName(source)]['admin']) >= 1) then
					for i, name in ipairs(adminGuns) do
						if(string.lower(string.sub(name, 8)) == command[2]) then
							TriggerClientEvent("spawnWeaponForPlayer", source, name)	
							
							Users[GetPlayerName(source)]['money'] = tonumber(Users[GetPlayerName(source)]['money']) - 400
							TriggerClientEvent("deducted", source, 400)
							saveMoney(source)	
							return
						end
					end
				end
				
				for i, name in ipairs(spawnAbleWeapons) do
					if(string.lower(string.sub(name, 8)) == command[2]) then			

						TriggerClientEvent("spawnWeaponForPlayer", source, name)	
						Users[GetPlayerName(source)]['money'] = tonumber(Users[GetPlayerName(source)]['money']) - 400
						TriggerClientEvent("deducted", source, 400)
						saveMoney(source)						
						return
					end
					
				end	

				TriggerClientEvent("chatMessage", source, '', {0,0,0}, "^1Weapon doesn't exist.")				
			else
				TriggerClientEvent("chatMessage", source, '', {0,0,0}, "^1You do not have enough money to spawn a weapon.")
				TriggerClientEvent("chatMessage", source, '', {0,0,0}, "^1You require: ^2💲400")
			end
		end
	elseif(command[1] == "/stats") then
		if(command[2] == nil)then
			TriggerClientEvent("chatMessage", source, '', {0,0,0}, "^4--- ^1".. GetPlayerName(source) .. " ^4---")
			TriggerClientEvent("chatMessage", source, '', {0,0,0}, "Money: ^2💲" .. tostring(Users[GetPlayerName(source)]['money']))
			
			if(tonumber(Users[GetPlayerName(source)]['deaths']) == 0 or tonumber(Users[GetPlayerName(source)]['kills']) == 0)then
				TriggerClientEvent("chatMessage", source, '', {0,0,0}, "K/D: ^1Cannot be calculated. (0 deaths/kills)")
			else
				TriggerClientEvent("chatMessage", source, '', {0,0,0}, "K/D: ^1" .. string.format("%.1f", (tonumber(Users[GetPlayerName(source)]['kills'])/tonumber(Users[GetPlayerName(source)]['deaths']))))
			end
		else
			if(GetPlayerName(tonumber(command[2])) ~= nil)then
				TriggerClientEvent("chatMessage", source, '', {0,0,0}, "^4--- ^1".. GetPlayerName(tonumber(command[2])) .. " ^4---")
				TriggerClientEvent("chatMessage", source, '', {0,0,0}, "Money: ^2💲" .. tostring(Users[GetPlayerName(tonumber(command[2]))]['money']))
				
				if(Users[GetPlayerName(tonumber(command[2]))]['deaths'] == 0 or Users[GetPlayerName(tonumber(command[2]))]['kills'] == 0)then
					TriggerClientEvent("chatMessage", source, '', {0,0,0}, "K/D: ^1Cannot be calculated. (0 deaths/kills)")
				else
					TriggerClientEvent("chatMessage", source, '', {0,0,0}, "K/D: ^1" .. string.format("%.1f", (tonumber(Users[GetPlayerName(tonumber(command[2]))]['kills'])/tonumber(Users[GetPlayerName(source)]['deaths']))))
				end
			end
		end
	elseif(command[1] == "/tp" and tonumber(Users[GetPlayerName(source)]['admin']) >= 1) then
		TriggerClientEvent("teleportToPlayer", source, command[2])
		TriggerClientEvent("chatMessage", tonumber(command[2]), '', { 0, 0x99, 255}, "You got teleported to by ^2"..GetPlayerName(source))
		TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "You teleported to ^2"..GetPlayerName(tonumber(command[2])))
	elseif(command[1] == "/tphere" and tonumber(Users[GetPlayerName(source)]['admin']) >= 1) then
		if(Users[GetPlayerName(tonumber(command[2]))] ~= nil)then
			if(tonumber(Users[GetPlayerName(tonumber(command[2]))]['admin']) > tonumber(Users[GetPlayerName(source)]['admin']))then
				SendPlayerChatMessage(source, "^2Your not allowed to target him!")
			else
			TriggerClientEvent("teleportToSender", tonumber(command[2]), source)
			TriggerClientEvent("chatMessage", tonumber(command[2]), '', { 0, 0x99, 255}, "You got teleported by ^2"..GetPlayerName(source))
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "You brought ^2"..GetPlayerName(tonumber(command[2])))
			end
		end
	elseif(command[1] == "/freeze" and tonumber(Users[GetPlayerName(source)]['admin']) >= 1) then
		if(Users[GetPlayerName(tonumber(command[2]))] ~= nil)then
			if(tonumber(Users[GetPlayerName(tonumber(command[2]))]['admin']) > tonumber(Users[GetPlayerName(source)]['admin']))then
				SendPlayerChatMessage(source, "^2Your not allowed to target him!")
			else
			TriggerClientEvent("AwesomeFreeze", tonumber(command[2]), true)
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "You froze ^2"..GetPlayerName(tonumber(command[2])))
			TriggerClientEvent("chatMessage", tonumber(command[2]), '', { 0, 0x99, 255}, "You got frozen by ^2"..GetPlayerName(source))
			end
		end
	elseif(command[1] == "/unfreeze" and tonumber(Users[GetPlayerName(source)]['admin']) >= 1) then
		TriggerClientEvent("AwesomeFreeze", tonumber(command[2]), false)
		TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "You unfroze ^2"..GetPlayerName(tonumber(command[2])))
		TriggerClientEvent("chatMessage", tonumber(command[2]), '', { 0, 0x99, 255}, "You got unfrozen by ^2"..GetPlayerName(source))
	elseif(command[1] == "/god" and tonumber(Users[GetPlayerName(source)]['admin']) >= 1) then
		if(Users[GetPlayerName(tonumber(command[2]))] ~= nil)then
			if(tonumber(Users[GetPlayerName(tonumber(command[2]))]['admin']) > tonumber(Users[GetPlayerName(source)]['admin']))then
				SendPlayerChatMessage(source, "^2Your not allowed to target him!")
			else
				TriggerClientEvent("AwesomeGod", tonumber(command[2]), true)
				TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "You godded ^2"..GetPlayerName(tonumber(command[2])))
				TriggerClientEvent("chatMessage", tonumber(command[2]), '', { 0, 0x99, 255}, "You got godded by ^2"..GetPlayerName(source))
			end
		end
	elseif(command[1] == "/ungod" and tonumber(Users[GetPlayerName(source)]['admin']) >= 1) then
		if(Users[GetPlayerName(tonumber(command[2]))] ~= nil)then
			if(Users[GetPlayerName(tonumber(command[2]))]['admin'] > tonumber(Users[GetPlayerName(source)]['admin']))then
				SendPlayerChatMessage(source, "^2Your not allowed to target him!")
			else
				TriggerClientEvent("AwesomeGod", tonumber(command[2]), false)
				TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "You ungodded ^2"..GetPlayerName(tonumber(command[2])))
				TriggerClientEvent("chatMessage", tonumber(command[2]), '', { 0, 0x99, 255}, "You got ungodded by ^2"..GetPlayerName(source))
			end
		end
	elseif(command[1] == "/kick" and tonumber(Users[GetPlayerName(source)]['admin']) >= 1) then
		if(Users[GetPlayerName(tonumber(command[2]))] ~= nil)then
			if(tonumber(Users[GetPlayerName(tonumber(command[2]))]['admin']) > tonumber(Users[GetPlayerName(source)]['admin']))then
				SendPlayerChatMessage(source, "^2Your not allowed to target him!")
			else
				DropPlayer(tonumber(command[2]), "You got kicked.")
		end
		end
	elseif(command[1] == "/setwanted" and tonumber(Users[GetPlayerName(source)]['admin']) >= 1) then
		if(Users[GetPlayerName(tonumber(command[2]))] ~= nil)then
		if(Users[GetPlayerName(tonumber(command[2]))]['admin'] > tonumber(Users[GetPlayerName(source)]['admin']))then
				SendPlayerChatMessage(source, "^2Your not allowed to target him!")
			else
				TriggerClientEvent("AwesomeSetWanted", tonumber(command[2]), tonumber(command[3]))
				TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "You set wanted of ^2"..GetPlayerName(tonumber(command[2])).." ^0to ^2"..tonumber(command[3]))
				TriggerClientEvent("chatMessage", tonumber(command[2]), '', { 0, 0x99, 255}, "Wanted set to ^2"..tonumber(command[3]).." ^0by ^2"..GetPlayerName(source))
			end
		end
	elseif(command[1] == "/setlevel" and tonumber(Users[GetPlayerName(source)]['admin']) > 3)then
		if(Users[GetPlayerName(tonumber(command[2]))] ~= nil)then
		if(tonumber(Users[GetPlayerName(tonumber(command[2]))]['admin']) > tonumber(Users[GetPlayerName(source)]['admin']))then
				SendPlayerChatMessage(source, "^2Your not allowed to target him!")
			else
				Users[GetPlayerName(tonumber(command[2]))]['admin'] = tonumber(command[3])
				TriggerClientEvent("chatMessage", -1, 'CONSOLE', { 255, 0, 0}, "^2" .. GetPlayerName(tonumber(command[2])) .. " ^0access level has been set to ^2" .. command[3])
			
				MySQL:executeQuery("UPDATE users SET admin='@newKD' WHERE username = '@username'",
				{['@username'] = GetPlayerName(tonumber(command[2])), ['@newKD'] = tonumber(command[3])})
			end
		else
			SendPlayerChatMessage(source, "^2Target does not exist.")
		end
	elseif(command[1] == "/top") then
		local res = topMoney()
		print(res['money'].." "..res['username'])
		TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^2🏆"..res['username'].."^0 has the highest money, he has: ^2💲"..tostring(res['money']))
	elseif(command[1] == "/heal") then
		if(tonumber(Users[GetPlayerName(source)]['money']) >= 200)then
			TriggerClientEvent("setHealth", source, 99)
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^2➕You succesfully purschased ^4health^2! ^3For ^2💲200")
			Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] - 200
			TriggerClientEvent("deducted", source, 200)
			saveMoney(source)
		else
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1You do not have enough money for health! You need: 💲200")
		end
	elseif(command[1] == "/armor") then
		if(tonumber(Users[GetPlayerName(source)]['money']) >= 200)then
			TriggerClientEvent("setArmour", source, 100)
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^2💰You succesfully purschased ^4armour^2! ^3For ^2💲200")
			Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] - 200
			TriggerClientEvent("deducted", source, 200)
			saveMoney(source)
		else
			TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1You do not have enough money for armour! You need: ^2💲200")
		end
	elseif(command[1] == "/getip" and Users[GetPlayerName(source)]['admin'] >= 1)then
		TriggerClientEvent("chatMessage", source, '', {0,0x99,255}, "IP: "..GetPlayerIdentifiers(tonumber(command[3])))
	elseif(personalVehicleChatCommands(source, command))then
	elseif(commandManagerHeistJob(source, command))then
	elseif(crewChatCommands(source, command))then
	elseif(businessChatCommands(source, command))then		
	elseif(command[1] == "/pos") then	
		TriggerClientEvent("getPosition", source)
	elseif(command[1] == "/obj") then
		TriggerClientEvent("spawnObject", source)
	else
		if(businessChatCommands(source, command) == false)then
				TriggerClientEvent("chatMessage", source, '', { 0, 0x99, 255}, "^1Invalid Command!")
		end
    end
end)

-- Money
function givePlayersMoney()
	SetTimeout(120000, function()
		for i = 1, 100 do
			if(GetPlayerName(i) ~= nil)then
				if(Users[GetPlayerName(i)] ~= nil)then
					Users[GetPlayerName(i)]['money'] = Users[GetPlayerName(i)]['money'] + 750
					saveMoney(i)
					TriggerClientEvent("paid", i, 750)
				end
			end
		end
		givePlayersMoney()
	end)
end
givePlayersMoney()

function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end

function SendPlayerChatMessage(source, message, color)
	if(color == nil) then
		color = { 0, 0x99, 255}
	end
	TriggerClientEvent("chatMessage", source, '', color, message)
end


print("[FREEROAM - KANERSPS] Gamemode initialized. V6")