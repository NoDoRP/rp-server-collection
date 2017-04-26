function f(n)
n = n + 0.00001
return n
end

--Text drawing function
local function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)    
end

	local openMenu = false
	local torsoMenu = false
	local mainMenu = true
	local headMenu = false
	local currSelected = 1
	local selectorX = 0.8
	local selectorY = 0.137
	
	local torsoVariation = 1
	local headVariation = 1
	local torsoVariationVar = 1
	local headVariationStyle = 1
	local torsoVariationVar2 = 1
	local torsoTexture = 1
	local torsoDrawable = 1
	local hairDrawable = 1
	local hairTexture = 1
	local torsoBody3 = 1
	local PlayerSkins = {0x15F8700D,0x028ABF95,0x52580019,0xEDBC7546,0xDE0077FD,0x56C96FC6,0xE497BBEF,0x65793043,0x0D7114C9,0x95C76ECD,0xA96BD9EC,0x58D696FE}
	local torsoSkin = 1
	
	local torsoBodyDrawable = 1
	local torsoBodyTexture = 1
	
	-- Max
	local maxDrawablesTorso = 1
	local maxTextureTorso = 1
	
	local maxDrawableBody = 1
	local maxTextureBody = 1
	
	local maxDrawableHair = 1
	local maxTextureHair = 1
	
	RegisterNetEvent("fullCompanyIncome")
	AddEventHandler("fullCompanyIncome", function(income)
		TriggerEvent("chatMessage", '', {0,0,0}, "^4Your company net-income is: ^2$"..income)
	end)
	
	
local function count(input)
  if type(input)~='table' then
   return nil
  end
  local int=0
  for k,v in pairs(input) do
   int=int+1
  end
  return int
end
	
Citizen.CreateThread(function()
	
	
	while true do
		Citizen.Wait(0)
		
		if(openMenu)then
			if(IsControlJustReleased(1, 57))then
				openMenu = false
			end
			
			local x = 0.8
			local y = 0.1
			x = f(x)
			y = f(y)		
			
			
			if(IsControlJustReleased(1, 11))then
				if(currSelected < 11)then
					currSelected = currSelected + 1
					selectorY = selectorY + 0.037
				end
			end
			if(IsControlJustReleased(1, 10))then	
				if(currSelected-1 > 0)then
					currSelected = currSelected - 1
					selectorY = selectorY - 0.037
				end
			end
			
			if(currSelected == 2 or currSelected == 6)then
				if(IsControlJustReleased(1, 10))then
					currSelected = currSelected - 1
					selectorY = selectorY - 0.037
				elseif(IsControlJustReleased(1, 11))then
					currSelected = currSelected + 1
					selectorY = selectorY + 0.037
				end
			end
			
			if(IsControlJustReleased(1, 215))then
				
			
				if(mainMenu)then
					if(currSelected == 1)then
						if(torsoSkin > #PlayerSkins)then
							torsoSkin = 1
						end
					
						local modelID = torsoSkin
						modelID = PlayerSkins[torsoSkin]
						
						RequestModel(modelID)
						while not HasModelLoaded(modelID) do
							Citizen.Wait(0)
						end
						
						SetPlayerModel(PlayerId(), modelID)
						
						torsoSkin = torsoSkin + 1
						
					elseif(currSelected == 3)then
						TriggerServerEvent("spawnPersonalVehicle")
					elseif(currSelected == 4)then
						TriggerEvent("fixPersonalVehicle")
					elseif(currSelected == 5)then
						TriggerEvent("upgradePlayerVehicle")
					elseif(currSelected == 7)then
						TriggerServerEvent("requestFullCompanyIncome")
					elseif(currSelected == 8)then
						TriggerServerEvent("requestFullCompanyNames")
					end
				end
				
			end
			
			if(mainMenu)then				
			
				drawTxt(x - 0.1,y+0.03,0.3,0.035,0.35, "Controls",255,255,255,255)			
				drawTxt(x - 0.1,y + 0.05,0.3,0.035,0.35, "Page up - Move up",255,255,255,255)			
				drawTxt(x - 0.1,y + 0.07,0.3,0.035,0.35, "Page down - Move down",255,255,255,255)			
				drawTxt(x - 0.1,y + 0.09,0.3,0.035,0.35, "Enter - Select option",255,255,255,255)	
			
				DrawRect(x,y,0.1,0.035,220,220,220,150)
				drawTxt(x + 0.105,y,0.3,0.035,0.35, "Quick options",255,255,255,255)
				
				
				
				y = y + 0.037				
				DrawRect(x,y,0.2,0.035,100,100,100,255)
				local length = count(PlayerSkins)
				drawTxt(x + 0.005,y,0.2,0.035,0.35, "Skin   "..(torsoSkin-1).."/"..length,255,255,255,255)
				
				y = y + 0.037				
				DrawRect(x,y,0.2,0.035,100,100,100,255)
				local length = count(PlayerSkins)
				drawTxt(x + 0.005,y,0.2,0.035,0.35, "--- Personal Vehicle ---",255,255,255,255)
				
				y = y + 0.037				
				DrawRect(x,y,0.2,0.035,100,100,100,255)
				drawTxt(x + 0.005,y,0.2,0.035,0.35, "Spawn",255,255,255,255)
				
				y = y + 0.037				
				DrawRect(x,y,0.2,0.035,100,100,100,255)
				drawTxt(x + 0.005,y,0.2,0.035,0.35, "Fix",255,255,255,255)
				
				y = y + 0.037				
				DrawRect(x,y,0.2,0.035,100,100,100,255)
				drawTxt(x + 0.005,y,0.2,0.035,0.35, "Upgrade",255,255,255,255)
				
				y = y + 0.037				
				DrawRect(x,y,0.2,0.035,100,100,100,255)
				drawTxt(x + 0.005,y,0.2,0.035,0.35, "--- Companies ---",255,255,255,255)
				
				y = y + 0.037				
				DrawRect(x,y,0.2,0.035,100,100,100,255)
				drawTxt(x + 0.005,y,0.2,0.035,0.35, "Request total income",255,255,255,255)
				
				y = y + 0.037				
				DrawRect(x,y,0.2,0.035,100,100,100,255)
				drawTxt(x + 0.005,y,0.2,0.035,0.35, "Request company names",255,255,255,255)
				
			end
			
			DrawRect(selectorX,selectorY,0.2,0.035,150,150,150,255)
		else
			if(IsControlJustReleased(1, 57))then
				openMenu = true
			end
		end
	end
end)