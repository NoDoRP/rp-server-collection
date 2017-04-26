RegisterServerEvent("chatCommandEntered")
RegisterServerEvent('chatMessageEntered')

AddEventHandler("chatMessage", function(p, color, msg)
    if msg:sub(1, 1) == "/" then
        fullcmd = stringSplit(msg, " ")
        cmd = fullcmd[1]
        
        if cmd == "/rappel" then
            TriggerClientEvent("CGC:rappel", p)
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