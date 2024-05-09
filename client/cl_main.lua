RegisterCommand("truckSavePos", function(source, args, rawCommand)
    if #args == 1 then
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local heading = GetEntityHeading(GetPlayerPed(-1))
        local stringOuput = args[1].."  {vector3("..round(coords.x)..", "..round(coords.y)..", "..round((coords.z + 1.0)).."), "..round(heading).."}\n"
        TriggerServerEvent("erp-vectorSaver-sv:saveToFile", "truck", stringOuput)
    end
end, true)

RegisterCommand("towlocation", function(source, args, rawCommand)
    if #args == 1 then
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local heading = GetEntityHeading(GetPlayerPed(-1))
        local stringOuput = "{vector4("..round(coords.x)..", "..round(coords.y)..", "..round((coords.z))..", "..round((heading)).."), "..tonumber(args[1]).."},\n"
        TriggerServerEvent("erp-vectorSaver-sv:saveToFile", "tow", stringOuput)
    end
end, true)

RegisterCommand("drawcoord", function(source, args, rawCommand)
    local startTime = GetNetworkTime()
    while GetNetworkTime() - startTime < 5000 do
        DrawSphere(tonumber(args[1]), tonumber(args[2]), tonumber(args[3]), 0.05, 255, 0, 0, 0.2)
        Citizen.Wait(1)
    end
end, false)

RegisterCommand("drawpos", function(source, args, rawCommand)
    local startTime = GetNetworkTime()
    local coords = GetEntityCoords(PlayerPedId(), false)
    while GetNetworkTime() - startTime < 5000 do
        DrawSphere(coords, 0.05, 255, 0, 0, 0.2)
        Citizen.Wait(1)
    end
end, true)

local drawingRadius = false

RegisterCommand("drawradius", function(source, args, rawCommand)
    if not drawingRadius then
        local startTime = GetNetworkTime()
        local coords = GetEntityCoords(PlayerPedId(), false)
        local radius = tonumber(args[1])
        drawingRadius = true
        while drawingRadius do
            DrawSphere(coords, radius, 255, 0, 0, 0.3)
            coords = GetEntityCoords(PlayerPedId(), false)
            Citizen.Wait(1)
        end
    else
        drawingRadius = false
    end
end, true)

RegisterCommand("seatpos", function(source, args, rawCommand)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local heading = GetEntityHeading(GetPlayerPed(-1))
    local stringOuput = ""
    if #args == 1 then
        if string.lower(args[1]) == "behind" then
            coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.6, 0.0)
            stringOuput = "{vector4("..round(coords.x)..", "..round(coords.y)..", "..round((coords.z))..", "..heading.."), { scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.45, forwardOffset = 0.0, leftOffset = 0.0}},\n"
        elseif string.lower(args[1]) == "front" then
            coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, -0.6, 0.0)
            stringOuput = "{vector4("..round(coords.x)..", "..round(coords.y)..", "..round((coords.z))..", "..heading.."), { scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.55, forwardOffset = 0.0, leftOffset = 0.0}},\n"
        end
    else
        stringOuput = "{vector4("..round(coords.x)..", "..round(coords.y)..", "..round((coords.z))..", "..heading.."), { scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.95, forwardOffset = 0.0, leftOffset = 0.0}},\n"
    end
    TriggerServerEvent("erp-vectorSaver-sv:saveToFile", "chair", stringOuput)
end, true)

function round(num)
    return math.floor(((num*100)+0.5))/100
end