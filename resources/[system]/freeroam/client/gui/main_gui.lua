myPlayer = {}
myPlayer.money = 0

function f(n)
n = n + 0.00001
return n
end

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
	SetEntityCoords()
end


RegisterNetEvent("clientPlayerData")
AddEventHandler("clientPlayerData", function(cash)
	myPlayer.money = cash
	
	SendNUIMessage({
		setmoney = true,
		money = cash
	})
end)

RegisterNetEvent("clientPaid")
AddEventHandler("clientPaid", function()
	SendNUIMessage({
		removeStartWindow = true,
	})
end)

RegisterNetEvent("paid")
AddEventHandler("paid", function(amount)
	SendNUIMessage({
		addcash = true,
		money = amount
	})
end)

RegisterNetEvent("deducted")
AddEventHandler("deducted", function(amount)
	SendNUIMessage({
		removecash = true,
		money = amount
	})
end)