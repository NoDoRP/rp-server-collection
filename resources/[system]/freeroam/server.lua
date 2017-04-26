RegisterServerEvent('playerSpawn')
AddEventHandler('playerSpawn', function()
	-- Spawn the player at: X: 100, Y: 100, Z: 100
	TriggerClientEvent('es_example_gamemode:spawnPlayer', source, 100.0, 100.0, 100.0 --[[, model -- you can put a model here]])
end)