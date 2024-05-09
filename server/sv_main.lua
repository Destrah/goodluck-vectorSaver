
RegisterCommand("garbagelocation", function(source, args, rawCommand)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local heading = GetEntityHeading(GetPlayerPed(source))
    local stringOuput = "{type = 'Collection', size = 5.0 , name = 'collection', pos = " .. "vector3("..round(coords.x)..", "..round(coords.y)..", "..round((coords.z - 0.5))..")},\n"
    TriggerEvent("erp-vectorSaver-sv:saveToFile", "garbage", stringOuput)
end, true)

RegisterNetEvent("erp-vectorSaver-sv:saveToFile")
AddEventHandler("erp-vectorSaver-sv:saveToFile", function(type, dataString)
    local file = nil
    if type == "truck" then
        file = io.open('truckpositions.txt', "a")
    elseif type == "chair" then
        file = io.open('seatpositions.txt', "a")
    elseif type == "tow" then
        file = io.open('towlocations.txt', "a")
        print('Check')
    elseif type == "garbage" then
        file = io.open('garbagelocations.txt', "a")
        print('Check')
    end
    io.output(file)
    io.write(dataString)
    io.close(file)
end)

function round(num)
    return math.floor(((num*100)+0.5))/100
end