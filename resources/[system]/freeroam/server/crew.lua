function isPartOfCrew(playerName)
	local executed_query = MySQL:executeQuery("SELECT * FROM crews")
	local result = MySQL:getResults(executed_query, {'owner', 'members'})
	
	for i,name in ipairs(result)do
		if(result[i]['owner'] == playerName)then
			return true
		else
			local members = stringsplit(result[i]['members'], ",")
			for j,nam in ipairs(members)do
				if(members[j] == playerName)then
					return true
				end
			end
		end
	end
	
	return false
end

function isPartOfCrew2(playerName)
	local executed_query = MySQL:executeQuery("SELECT * FROM crews")
	local result = MySQL:getResults(executed_query, {'owner', 'members'})
	
	for i,name in ipairs(result)do
		if(result[i]['owner'] == playerName)then
			return result[i]
		else
			local members = stringsplit(result[i]['members'], ",")
			for j,nam in ipairs(members)do
				if(members[j] == playerName)then
					return result[i]
				end
			end
		end
	end
	
	return nil
end

function GetPlayerID(name)
	for i = 0, 32 do
	print("testing: " .. GetPlayerName(i))
		if(string.lower(GetPlayerName(i)) == string.lower(name)) then
			return i
		end
	end
  return nil
end

function isOwnerOfCrew(playerName)
	local executed_query = MySQL:executeQuery("SELECT * FROM crews")
	local result = MySQL:getResults(executed_query, {'owner', 'members'})
	
	for i,name in ipairs(result)do
		if(result[i]['owner'] == playerName)then
			return result[i]
		end
	end
	
	return nil
end

function saveCrewInvitations(crewOwner, invText)
	local executed_query = MySQL:executeQuery("SELECT * FROM crews")
	local result = MySQL:getResults(executed_query, {'owner', 'name', 'members', 'invitations'})
	
	MySQL:executeQuery("UPDATE crews SET invitations='@newIncome' WHERE owner='@owner'",
	{["@owner"]=crewOwner, ['@newIncome'] = invText})
end

function saveCrewMembers(crewOwner, invText)
	local executed_query = MySQL:executeQuery("SELECT * FROM crews")
	local result = MySQL:getResults(executed_query, {'owner', 'name', 'members', 'invitations'})
	
	MySQL:executeQuery("UPDATE crews SET members='@newIncome' WHERE owner='@owner'",
	{["@owner"]=crewOwner, ['@newIncome'] = invText})
end

function crewChatCommands(source, command)
	if(command[1] == "/crew")then
		local executed_query = MySQL:executeQuery("SELECT * FROM crews")
		local result = MySQL:getResults(executed_query, {'owner', 'members', 'name', 'flags', 'invitations'})
		if(command[2] == nil)then
			
			
			for i,name in ipairs(result)do
				if(result[i]['owner'] == GetPlayerName(source))then
					SendPlayerChatMessage(source, "^1--- Your Crew: ^4"..result[i]['name'].."^1 ---")
					SendPlayerChatMessage(source, "^5👥 Members: ^2"..result[i]['members'])
					return true
				else
					local allMembers = stringsplit(result[i]['members'], ",")
					for j,nam in ipairs(allMembers)do
						if(allMembers[j] == GetPlayerName(source))then
							SendPlayerChatMessage(source, "^1--- Member of: ^4"..result[i]['name'].."^1 ---")
							SendPlayerChatMessage(source, "^5👤Owner: ^2"..result[i]['owner'])
							SendPlayerChatMessage(source, "^5👥 Members: ^2"..result[i]['members'])
							return true
						end
					end
				end
			end
			
			SendPlayerChatMessage(source, "^1You do not belong to a crew. Create one with: /crew create [Name](^2💲25000^1)")
		elseif(command[2] == "create")then
			if(isPartOfCrew(GetPlayerName(source)) == false)then
				if(Users[GetPlayerName(source)]['money'] >= 25000)then
					if(command[3] ~= nil)then
						Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] - 25000
						saveMoney(source)
						SendPlayerChatMessage(source, "^2You created the crew: ^4"..command[3])
						MySQL:executeQuery("INSERT INTO crews (`owner`, `members`, `name`) VALUES ('@owner', '', '@name')",
						{['@owner'] = GetPlayerName(source), ['@name'] = command[3]})			
					else
						SendPlayerChatMessage(source, "^2You did not enter a crew name!")
					end
				else
					SendPlayerChatMessage(source, "^1You do not have enough money.")
				end
			else
				SendPlayerChatMessage(source, "^1You are part of a crew. Leave with /crew leave")
			end
		elseif(command[2] == "kick")then
		elseif(command[2] == "invite")then
			if(isOwnerOfCrew(GetPlayerName(source)) ~= nil)then
				local crew = nil
				
				for t,n in ipairs(result)do
					if(result[t]['owner'] == GetPlayerName(source))then
						crew = result[t]
					end
				end
				
				if(command[3] ~= nil)then
					if(Users[command[3]] ~= nil)then
						if(crew['invitations'] == "")then
							crew['invitations'] = command[3]
							saveCrewInvitations(GetPlayerName(source), crew['invitations'])
							SendPlayerChatMessage(source, "^2Succesfully invited: ^4"..command[3].."^2!")
						else
							local isAlreadyInvited = false
							local isAlreadyInCrew = false
							
							local invs = stringsplit(crew['invitations'], ",")
							
							for u,d in ipairs(invs)do
								if(invs[u] == command[3])then
									isAlreadyInvited = true
								end
							end
							
							local executed_query = MySQL:executeQuery("SELECT * FROM crews")
							local result3 = MySQL:getResults(executed_query, {'owner', 'members'})
							
							for r,t in ipairs(result3)do
								if(result3[r]['owner'] == command[3])then
									isAlreadyInCrew = true
								else
									local membs = stringsplit(result3[r]['members'],",")
									for o,p in ipairs(membs)do
										if(membs[o] == command[3])then
											isAlreadyInCrew = true
										end
									end
								end
							end
							
							--if not isAlreadyInCrew then
								if not isAlreadyInvited then
									crew['invitations'] = crew['invitations']..","..command[3]
									saveCrewInvitations(GetPlayerName(source), crew['invitations'])
									SendPlayerChatMessage(source, "^2 ✉ Succesfully invited: ^4"..command[3].."^2!")
									print('Player invited by name of: '..GetPlayerName(tonumber(GetPlayerID(command[3]))))
									SendPlayerChatMessage(tonumber(GetPlayerID(command[3])), "^2 📩 You were invited to: ^4"..crew['name'].."^2 type /crew join "..crew['name'].." to accept.")
								else
									SendPlayerChatMessage(source, "^1User already invited.")
								end
							--else
								--SendPlayerChatMessage(source, "^1User already in crew.")
							--end
						end
					else
						SendPlayerChatMessage(source, "^1User is currently not online.")
					end
				else
					SendPlayerChatMessage(source, "^1Please enter a player name.")
				end
			else
				SendPlayerChatMessage(source, "^1You don't own a crew.")
			end
		elseif(command[2] == "join")then	
			local isPartOfCrew = false
			
			for i,name in ipairs(result) do
				if(result[i]['owner'] == GetPlayerName(source))then
					isPartOfCrew = true
				end
				
				local membs = stringsplit(result[i]['members'],",")
				for j,nam in ipairs(membs)do
					if(membs[j] == GetPlayerName(source))then
						isPartOfCrew = true
					end
				end
			end
			
			if(isPartOfCrew == false)then
				for i,name in ipairs(result)do
					local invs = stringsplit(result[i]['invitations'], ",")
					for j,nam in ipairs(invs)do
						if(invs[j] == GetPlayerName(source))then
							if(command[3] ~= nil)then
								if(command[3] == result[i]['name'])then
									local crewMembers = ""
									if(result[i]['members'] == "")then
										crewMembers = GetPlayerName(source)
									else
										crewMembers =  result[i]['members']..","..GetPlayerName(source)
									end
									
									local invs2 = string.gsub( result[i]['invitations'], ","..GetPlayerName(source), "" ) 
									saveCrewInvitations(result[i]['owner'], invs2)
								
									saveCrewMembers(result[i]['owner'], crewMembers)
									SendPlayerChatMessage(source, "^1You joined: "..result[i]['name'])
								end
							else
								SendPlayerChatMessage(source, "^2Please entered the crew you want to join.")
								return true
							end
						else
						end
					end
				end
			else
				SendPlayerChatMessage(source, "^1You are already part of a crew! Leave with /crew leave")
				return true
			end
			SendPlayerChatMessage(source, "^1You are not invited to any crew.")
		elseif(command[2] == "leave")then	
			local isPartOfCrew = false
			
			for i,name in ipairs(result) do				
				local membs = stringsplit(result[i]['members'],",")
				for j,nam in ipairs(membs)do
					if(membs[j] == GetPlayerName(source))then
						isPartOfCrew = true
					end
				end
			end
			
			if(isPartOfCrew == true)then
				local crew = nil
				
				for i,name in ipairs(result) do					
					local membs = stringsplit(result[i]['members'],",")
					for j,nam in ipairs(membs)do
						if(membs[j] == GetPlayerName(source))then
							crew = result[i]
						end
					end
				end
				
				local invs2 = string.gsub( crew['members'], ","..GetPlayerName(source), "" ) 
				local invs2 = string.gsub( crew['members'], ""..GetPlayerName(source), "" ) 
				
				saveCrewMembers(crew['owner'], invs2)
				SendPlayerChatMessage(source, "^2You left: "..crew['name'])
			else
				SendPlayerChatMessage(source, "^1You are not in a crew!")
			end
		elseif(command[2] == "disband")then				
		else
			SendPlayerChatMessage(source, "^1That is not a valid sub-command: create,join,invite,kick")
		end
		return true
	end
end