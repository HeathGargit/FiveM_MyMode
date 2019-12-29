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
                args = { "Welcome to the partay!!!~" }
            })
        end)
    end)
    
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
end)

RegisterCommand('car', function(source, args)
    -- account for the argument not being passed
    local vehicleName = args[1] or 'adder'

    --check if the car exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TriggerEvent('chat:addMessage', {
            args = {'Tried to summon a ' .. vehicleName .. ' but ^*failed!'}
        })

        return
    end

    
    --load the car's model
    RequestModel(vehicleName)
    
    -- wait for the model to laod
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end
    
    -- Get player coords
    local playerPed = PlayerPedId() -- Get the ped object
    local pos = GetEntityCoords(playerPed) -- pos vec3
    
    TriggerEvent('chat:addMessage', {
        args = {'script got up to here '}
    })
    -- create the car
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    --set player into car
    SetPedIntoVehicle(playerPed, vehicle, -1)

    -- give the vehicle back tot he game (this'll make the game decide when to despawn the vehicle)
    SetEntityAsNoLongerNeeded(vehicle)

    --release the model
    SetModelAsNoLongerNeeded(vehicleName)

    --tell the player
    TriggerEvent( "chat:addMessage", { 
        args = { "Woo! Enjoy your " .. vehicleName .. "!" }
    })

    -- old contents --
    -- TODO make a vehicle, fun!
    --TriggerEvent('chat:addMessage', {
    --    args = {'I wish I could spawn this ' .. (args[1] or 'adder') .. ' but my owner was too lazy. Pepega' }
    --})
end, false)