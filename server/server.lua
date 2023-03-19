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

RegisterServerEvent('6x_itcompjob:server:packetsell')
AddEventHandler('6x_itcompjob:server:packetsell', function()
    local xPlayer = QBCore.Functions.GetPlayer(source)

    local smallbag = xPlayer.Functions.GetItemByName(Config.DeliveryItem)

    if smallbag ~= nil then
        xPlayer.Functions.RemoveItem(Config.DeliveryItem, 1)
        xPlayer.Functions.AddMoney('cash', Config.ItemPrice)
		TriggerClientEvent('QBCore:Notify', source, Lang:t("notify.deliverynotify") ..Config.ItemPrice, "primary", 5000)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.DeliveryItem], "remove", 1)
	end
end)

QBCore.Functions.CreateCallback('6x_itcompjob:itemcheck', function(source, cb, item)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local itemcount = xPlayer.Functions.GetItemByName(item)
	if itemcount ~= nil then
		cb(true)
	else
        cb(false)
	end
end)
