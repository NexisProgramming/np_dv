-- Car Command
-- Define the Ace permission required to use the command
RegisterCommand('car', function(source, args)
  -- Check if the player has the required Ace permission
  if IsPlayerAceAllowed(source, ScriptReaper.Spawn_Car_Permission) then
    -- Get the vehicle name from the arguments, or use a default if no argument was provided
    local vehicleName = args[1] or 'adder'

    -- Check if the vehicle exists in the game
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
      TriggerClientEvent('chat:addMessage', source, { args = { '^1Error', 'This vehicle does not exist in the game.' } })
      return
    end

    -- Load the vehicle model
    RequestModel(vehicleName)
    while not HasModelLoaded(vehicleName) do
      Wait(500)
    end

    -- Get the player's position and create the vehicle at that location
    local playerPed = GetPlayerPed(source)
    local pos = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    -- Put the player into the driver seat
    SetPedIntoVehicle(playerPed, vehicle, -1)

    -- Release the vehicle and model resources
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)

    -- Send a success message to the client
    TriggerClientEvent('chat:addMessage', source, { args = { '^1Success', 'You have spawned a ' .. vehicleName .. '.' } })
  else
    -- Show an error message to the player if they don't have the permission
    TriggerClientEvent('chat:addMessage', source, { args = { '^1Error', 'You do not have permission to use this command.' } })
  end
end, false)



-- DV Command
RegisterCommand('dv', function(source, args, rawCommand)
    -- Get the player's server ID and Ped
    local playerId = tonumber(source)
    local playerPed = GetPlayerPed(playerId)
    -- Get the vehicle the player is in
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if DoesEntityExist(vehicle) then
      -- Delete the vehicle and show a success message to the player
      DeleteEntity(vehicle)
      TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Success', 'Your vehicle has been deleted.' } })
    else
      -- Show an error message to the player
      TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Error', 'You are not in a vehicle.' } })
  end
end, false)
