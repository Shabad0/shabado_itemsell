local QBCore = exports['qb-core']:GetCoreObject()
local spawnedPeds = {}

-- Spawn each ped defined in Config and add qb-target interactions.
Citizen.CreateThread(function()
    for _, pedData in pairs(Config.Peds) do
        local model = GetHashKey(pedData.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(10)
        end

        local ped = CreatePed(4, model, pedData.coords.x, pedData.coords.y, pedData.coords.z - 1.0, pedData.coords.w, false, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        table.insert(spawnedPeds, ped)

        -- Add qb-target for the spawned ped.
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    type = "client",
                    event = "myScript:sellItems",
                    icon = "fas fa-shopping-cart",
                    label = "Sell Items",
                    data = {  -- You can also try using 'params' here if 'data' isn’t working.
                        items = pedData.items
                    }
                }
            },
            distance = 2.5,
        })
    end
end)

-- Open the sell menu when a player interacts with the ped.
RegisterNetEvent('myScript:sellItems', function(data, entity)
   -- print("sellItems event data:", json.encode(data))
    
    -- Check for items in different possible structures:
    local items = data.items or (data.data and data.data.items) or (data.params and data.params.items)
    
    if not items then
        print("Error: No items provided to sell.")
        return
    end

    local menu = {
        {
            header = "Sell Items",
            isMenuHeader = true,
        }
    }

    for _, item in ipairs(items) do
        local itemData = QBCore.Shared.Items[item.name]
        local displayLabel = item.label or (itemData and itemData.label or item.name)
        table.insert(menu, {
            header = displayLabel .. " - $" .. item.price,
            txt = "Sell your " .. displayLabel,
            params = {
                event = "myScript:sellItem",
                args = { item = item }
            }
        })
    end

    table.insert(menu, {
        header = "Close",
        txt = "",
        params = { event = "qb-menu:closeMenu" }
    })

    exports['qb-menu']:openMenu(menu)
end)

-- When an item is selected from the menu, trigger a server event to process the sale.
RegisterNetEvent('myScript:sellItem', function(data)
    local item = data.item
    TriggerServerEvent('myScript:processSale', item)
end)
