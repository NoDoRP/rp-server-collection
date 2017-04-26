function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('0x7FB2D428', 'T10 LMS')
  AddTextEntry('0x7FB2D428', 'T10 LMS')
end)
