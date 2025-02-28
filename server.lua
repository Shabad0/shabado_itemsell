local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('myScript:processSale', function(item)
    local src = source
    print("ProcessSale triggered for player " .. tostring(src) .. " for item: " .. tostring(item.name))
    
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local itemInfo = Player.Functions.GetItemByName(item.name)
        if itemInfo and itemInfo.amount > 0 then
            print("Player has item, amount: " .. tostring(itemInfo.amount))
            local totalPrice = item.price * itemInfo.amount
            Player.Functions.RemoveItem(item.name, itemInfo.amount)
            Player.Functions.AddMoney("cash", totalPrice)
            TriggerClientEvent('QBCore:Notify', src, "You sold " .. itemInfo.amount .. " " .. item.name .. " for $" .. totalPrice, "success")
        else
            print("Player does not have any of the item: " .. tostring(item.name))
            TriggerClientEvent('QBCore:Notify', src, "You don't have any " .. item.name, "error")
        end
    else
        print("Player not found for source: " .. tostring(src))
    end
end)
