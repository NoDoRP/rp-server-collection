-- Spawn override
AddEventHandler('onClientMapStart', function()
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()

    exports.spawnmanager:setAutoSpawnCallback(function()
        TriggerServerEvent('playerSpawn')
        TriggerEvent('playerSpawn')
    end)
end)

-- Allows the server to spawn the player
RegisterNetEvent('es_example_gamemode:spawnPlayer')
AddEventHandler('es_example_gamemode:spawnPlayer', function(x, y, z, model)
    exports.spawnmanager:spawnPlayer({x = x, y = y, z = z, model = model})
end)