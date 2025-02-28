local QBCore = exports['qb-core']:GetCoreObject()
local spawnedPeds = {}
local pedMapping = {} -- Mapping ped entity to its configuration (includes ped name and items)

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
        pedMapping[ped] = pedData -- Save ped's config data

        -- Add qb-target for this ped, passing both items and pedName in the data
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    type = "client",
                    event = "myScript:sellItems",
                    icon = "fas fa-shopping-cart",
                    label = "Sell Items",
                    data = {
                        items = pedData.items,
                        pedName = pedData.name
                    }
                }
            },
            distance = 2.5,
        })
    end
end)

-- Event to open the sell menu
RegisterNetEvent('myScript:sellItems', function(data, entity)
   -- print("sellItems event data:", json.encode(data))
    
    -- Retrieve the items table (check possible nesting)
    local items = data.items or (data.data and data.data.items) or (data.params and data.params.items)
    if not items then
       -- print("Error: No items provided to sell.")
        return
    end

    -- Retrieve the ped's name either from the passed data or by looking up the entity mapping
    local pedName = data.pedName or (data.data and data.data.pedName) or "Sell Items"
    if entity and pedMapping[entity] and pedMapping[entity].name then
        pedName = pedMapping[entity].name
    end

    local menu = {
        {
            header = pedName, -- Dealer name at the top
            isMenuHeader = true,
        }
    }

    for _, item in ipairs(items) do
        table.insert(menu, {
            header = item.name .. " - $" .. item.price,
            txt = "Sell your " .. item.name,
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

   -- print("Opening menu with items:", json.encode(menu))
    exports['qb-menu']:openMenu(menu)
end)

-- Event that is triggered when a player selects an item to sell from the menu
RegisterNetEvent('myScript:sellItem', function(data)
    if not data or not data.item then
   --     print("Error: No item data passed to sellItem event.")
        return
    end

    local item = data.item
  --  print("Attempting to sell item:", json.encode(item))
    TriggerServerEvent('myScript:processSale', item)
end)
