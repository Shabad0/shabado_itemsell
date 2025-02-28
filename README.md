# shabado_itemsell

Configurable Sell Locations for QBCore

A lightweight resource for creating configurable selling points in your QBCore-based server. This script allows you to define various in-game sell locations with customizable NPCs (peds), locations, and item pricing—making it easy to tailor the selling experience to your server's theme.

Overview
The shabado_itemsell resource lets you set up selling points where players can sell items. Each sell location is defined by:

NPC Information: Customize the ped’s name and model.
Location: Specify the exact coordinates and heading for the ped.
Items: Define which items can be sold and whether their price is fixed or randomly generated.
This gives you complete flexibility to create unique and interactive sell zones throughout your server.

Installation
1. Download the Resource:
  *Clone or download the repository into your resources folder.
2. Configure Server Files:
 *Add the resource to your server configuration (e.g., in server.cfg) ensuring it loads after the required dependencies.
3. Restart Your Server:
  *Once installed, restart your server for the changes to take effect.

## Dependency

* [qb-core](https://github.com/qbcore-framework/qb-core)
* [qb-target](https://github.com/qbcore-framework/qb-target)
* [qb-menu](https://github.com/qbcore-framework/qb-menu) 

## Example Config

```lua
 {
    name = "change me",  -- The display name of the selling ped
    model = "a_m_y_business_01",  -- Ped model to use (refer to your model list)
    coords = vector4(-199.28, -650.47, 48.24, 332.93),  -- In-game coordinates and heading
    items = {
        { 
            name = "change_me", 
            price = math.random(5000, 10000)  -- Price will be randomized between 5000 and 10000 
        },
        { 
            name = "change_me", 
            price = 3500  -- Fixed price example 
        },
    },
}
