local spawnPos = vector3(-275.522, 6635.835, 7.425)


AddEventHandler('onClientGameTypeStart', function()
    exports.spawnmanager:setAutoSpawnCallback(function()
        exports.spawnmanager:spawnPlayer({
            x = spawnPos.x,
            y = spawnPos.y,
            z = spawnPos.z,
            model = 'a_m_m_skater_01'
        }, function()
            TriggerEvent('chat:addMessage', {
                args = { 'Welcome to the party!~' }
            })
        end)
    end)

    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
end)

RegisterCommand('car', function(source, args)
    -- account for the argument not being passed
    local vehicleName = args[1] or 'adder'

    -- check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TriggerEvent('chat:addMessage', {
            args = { 'It might have been a good thing that you tried to spawn a ' .. vehicleName .. '. Who even wants their spawning to actually ^*succeed?' }
        })

        return
    end


    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Wait(500) -- often you'll also see Citizen.Wait
    end


    local playerPed = PlayerPedId() 
    local pos = GetEntityCoords(playerPed) 

    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    SetPedIntoVehicle(playerPed, vehicle, -1)

    SetEntityAsNoLongerNeeded(vehicle)

    -- release the model
    SetModelAsNoLongerNeeded(vehicleName)

    -- tell the player
    TriggerEvent('chat:addMessage', {
		args = { 'Woohoo! Enjoy your new ^*' .. vehicleName .. '!' }
	})
end, false)
