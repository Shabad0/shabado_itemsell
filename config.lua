Config = {}

Config.Peds = {
    {
        name = "Art Dealer",        -- selling ped name
        model = "a_m_y_business_01",
        coords = vector4(-207.76, -650.79, 48.23, 346.4), -- position and heading
        items = {
            { name = "painting", price = math.random(800, 3500) },       -- item and price use math.random(5000, 10000) if you want to price to change between values after restarts 
        },
    },
   --[[ {
        name = "change me",
        model = "a_m_y_business_01",
        coords = vector4(-199.28, -650.47, 48.24, 332.93), -- position and heading
        items = {
            { name = "change_me", price = math.random(5000, 10000) },
            { name = "change_me", price = 3500 }, -- use this methon if you just want to never chnage
            { name = "change_me", price = 3500 },
        },
    },]]--
}