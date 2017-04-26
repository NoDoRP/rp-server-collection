function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('0x7AFB0EC5', 'Roosevelt Rod')
  AddTextEntry('0x7AFB0EC5', 'Roosevelt Rod')
end)
