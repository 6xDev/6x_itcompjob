local QBCore = exports['qb-core']:GetCoreObject()

local client = true
local status = false
local delivery = 0

Delivery.Coords = {
    [1] = {['x'] = 224.15, ['y'] = 513.55, ['z'] = 140.92,['h'] = 245.45, ['info'] = 'Vinewood 1'},
    [2] = {['x'] = 43.02, ['y'] = 468.85, ['z'] = 148.1,['h'] = 230.45, ['info'] = 'Vinewood 2'}, 
    [3] = {['x'] = 119.33, ['y'] = 564.1, ['z'] = 183.96,['h'] = 230.45, ['info'] = 'Vinewood 3'},
    [4] = {['x'] = -60.82, ['y'] = 360.56, ['z'] = 113.06,['h'] = 230.45, ['info'] = 'Vinewood 4'},
    [5] = {['x'] = -622.87, ['y'] = 488.81, ['z'] = 108.88,['h'] = 230.45, ['info'] = 'Vinewood 5'}, 
    [6] = {['x'] = -1040.67, ['y'] = 508.11, ['z'] = 84.38,['h'] = 123.45, ['info'] = 'Vinewood 6'}, 
    [7] = {['x'] = -1308.13, ['y'] = 448.9, ['z'] = 100.97,['h'] = 194.45, ['info'] = 'Vinewood 7'}, 
    [8] = {['x'] = -1733.21, ['y'] = 378.99, ['z'] = 89.73,['h'] = 194.45, ['info'] = 'Vinewood 8'},
    [9] = {['x'] = -2009.15, ['y'] = 367.42, ['z'] = 94.81,['h'] = 232.45, ['info'] = 'Vinewood 9'},
    [10] = {['x'] = -1996.29, ['y'] = 591.25, ['z'] = 118.1,['h'] = 232.45, ['info'] = 'Vinewood 10'},
}

RegisterNetEvent("6x_itcompjob:client:startdelivery")
AddEventHandler("6x_itcompjob:client:startdelivery", function()
    if client then 
        if delivery == 0 then
            TriggerEvent("6x_itcompjob:client:packetsell")
            TriggerEvent("6x_itcompjob:SpawnDeliveryVeh")
        else
            QBCore.Functions.Notify(Lang:t("notify.ondelivery"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("notify.realy"), "error")
    end
end)

RegisterNetEvent("6x_itcompjob:client:packetsell")
AddEventHandler("6x_itcompjob:client:packetsell", function()
    if client then
        random = math.random(1,#Config.DeliveryCoords)
        QBCore.Functions.Notify(Lang:t("notify.neworder"), "primary")
        SetNewWaypoint(Config.DeliveryCoords[random]["x"],Config.DeliveryCoords[random]["y"])
        blip = true
        status = true
        while status do
            local ped = PlayerPedId()
            local plycoords = GetEntityCoords(ped)
            local distance = #(plycoords - vector3(Config.DeliveryCoords[random]["x"],Config.DeliveryCoords[random]["y"],Config.DeliveryCoords[random]["z"])) 
            Citizen.Wait(1)
            if distance < 1.0 and client then
                QBCore.Functions.DrawText3D(Config.DeliveryCoords[random]["x"],Config.DeliveryCoords[random]["y"],Config.DeliveryCoords[random]["z"], Lang:t("qbmenu.deliver"))
                if IsControlJustPressed(1, 38) then
                    PacketSell2()
                end
            end	
        end
    end
end)

RegisterNetEvent("6x_itcompjob:client:sellingfinish")
AddEventHandler("6x_itcompjob:client:sellingfinish", function()
    if IsPedInAnyVehicle(PlayerPedId()) then
        if delivery == 1 then
            local car = GetVehiclePedIsIn(PlayerPedId(),true)
            NetworkFadeOutEntity(car, true,false)
            QBCore.Functions.DeleteVehicle(car)
            client = true
            status = false
            delivery = 0
            QBCore.Functions.Notify(Lang:t("notify.finish"), "primary")
        else
            QBCore.Functions.Notify(Lang:t("notify.notselling"), "primary")
        end
    else
        QBCore.Functions.Notify(Lang:t("notify.notfinish"), "primary")
    end
end)

function PacketSell2()
    local ped = PlayerPedId()
    QBCore.Functions.TriggerCallback('6x_itcompjob:itemcheck', function(data)
        if data then
            QBCore.Functions.Progressbar("packetsell", Lang:t("progress.packetselling"), Config.ProgressbarTime, false, true, { 
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
                }, {
                animDict = "timetable@jimmy@doorknock@",
                anim = "knockdoor_idle",
                flags = 49,
            }, {}, {}, function() -- Done
                TriggerServerEvent("6x_itcompjob:server:packetsell")
                TriggerEvent("6x_itcompjob:client:packetsell")
                map = true
                ClearPedTasksImmediately(ped)
            end, function() -- Cancel
                -- Cancel
            end)
        else
            QBCore.Functions.Notify(Lang:t("notify.needitem"), "error")
            client = false
        end
    end, Config.DeliveryItem) 
end

RegisterNetEvent("6x_itcompjob:SpawnDeliveryVeh", function() 
local coords = Config.CarSpawnCoord
QBCore.Functions.SpawnVehicle(Config.DeliveryVeh, function(veh)
    SetVehicleNumberPlateText(veh, Config.VehPlate)
    SetEntityHeading(veh, coords.w)
    exports[Config.Fuel]:SetFuel(veh, 100.0)
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
    SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)

RegisterCommand("try", function()
    client = true
    status = true
    delivery = 0
end)
