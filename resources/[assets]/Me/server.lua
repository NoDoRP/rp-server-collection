RegisterServerEvent("chatCommandEntered")
RegisterServerEvent('chatMessageEntered')


--[[
  After recieving a player message, Check if it is a /me message
  If it is print out [PLAYER NAME] [PLAYER MESSAGE]
  and print it in a random color.
]]

AddEventHandler("chatMessage", function(p, color, msg)
    if msg:sub(1, 1) == "/" then
        fullcmd = stringSplit(msg, " ")
        cmd = fullcmd[1]

        if cmd == "/Me" or cmd == "/me" or cmd == "/ME" then
            -- I've tried to make this work without the empty string and color, but it wouldn't work.
	          TriggerClientEvent('chatMessage', -1, "", {255, 0, 0}, "^" .. tostring(math.random(0, 9)) .. GetPlayerName(p) .. string.sub(msg, 4, -1))
            CancelEvent()
        end
    end
end)

function stringSplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end
