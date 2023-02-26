local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('6x_itcompjob:server:giveitem', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem(item)
end)

RegisterServerEvent('6x_itcompjob:server:takeitem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    Player.Functions.RemoveItem(item, amount)
end)

RegisterServerEvent('6x_itcompjob:server:givemoney', function(amount)
    local Player = QBCore.Functions.GetPlayer(source)
    
    Player.Functions.AddMoney('cash', amount)
end)

RegisterServerEvent('6x_itcompjob:server:givemoney2', function(amount)
    local Player = QBCore.Functions.GetPlayer(source)
    
    Player.Functions.AddMoney('bank', amount)
end)
