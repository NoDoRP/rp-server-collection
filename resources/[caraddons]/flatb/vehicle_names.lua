function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('0x810BF300', 'Yosemite Flatbed')
  AddTextEntry('0x810BF300', 'Yosemite Flatbed')
end)
