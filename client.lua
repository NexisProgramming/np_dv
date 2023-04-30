RegisterCommand('car', function(source, args)
    --account for the argument not being passed
    local vehicleName = args[1] or 'adder'

    --check if vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TriggerEvent('chat:addMessage', {
            args = {'Vehicle is not in this server' ..vehicleName}
        })
        return
    end

    --load the model
    RequestModel(vehicleName)
	
        --wait for model to load
        while not HasModelLoaded(vehicleName) do
            Wait(500)
        end

    --get location
    local playerPed = PlayerPedId() --get local player ped
    local pos = GetEntityCoords(playerPed)-- get posistion of player

    --create vehicle
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    --put player into the driver seat
    SetPedIntoVehicle(playerPed, vehicle, -1)

    --give vehicle back to game
    SetEntityAsNoLongerNeeded(vehicle)

    --release model
    SetModelAsNoLongerNeeded(vehicleName)

    --tell player its in
    TriggerEvent('chat:addMessage', {
        args = {'You have spawned a ' .. vehicleName .. '.'}
    })
end, false)

RegisterCommand('dv', function()
    --get local player ped
    local playerPed = PlayerPedId()
    --get vehicle
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    --delete vehicle
    DeleteEntity(vehicle)
end, false)