function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('0x4595C0CA', 'Police Dominator')
  AddTextEntry('0x4595C0CA', 'Police Dominator')
end)
